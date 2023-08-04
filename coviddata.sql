-- Covid 19 Data Exploration

SELECT *
FROM Portfolio.coviddeaths
WHERE continent IS NOT NULL
ORDER BY 3,4;

-- selecting our interested data

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM Portfolio.coviddeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- knowing the percentage of population infected by covid

SELECT Location, date, population, total_cases, (total_cases/population)*100 AS InfectedPercentPop
FROM Portfolio.coviddeaths
ORDER BY 1,2;

-- highest infection rate by countries compared to their population

SELECT Location, population, MAX(total_cases) AS HighestInfectionCount, MAX(total_cases/population)*100 AS InfectedPercentPop
FROM Portfolio.coviddeaths
GROUP BY Location, population
ORDER BY InfectedPercentPop DESC;

-- countries with highest death count per population 


SELECT Location, MAX(total_deaths) AS TotalDeathCount
FROM Portfolio.coviddeaths
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY TotalDeathCount DESC;

-- exploring the data by continent
-- continent with the highest death count per population 

SELECT continent, MAX(total_deaths) AS TotalDeathCount
FROM portfolio.coviddeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- global numbers

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths
FROM Portfolio.coviddeaths
WHERE continent IS NOT NULL;

-- diving into vaccination data
-- percentage of vaccinated people 

SELECT coviddeaths.continent, coviddeaths.location, coviddeaths.date, coviddeaths.population, covidvaccinations.new_vaccinations,
SUM(covidvaccinations.new_vaccinations) over (partition by coviddeaths.location ORDER BY coviddeaths.location, coviddeaths.date) AS PeopleVaccinated
FROM Portfolio.coviddeaths
JOIN Portfolio.covidvaccinations 
ON coviddeaths.location = covidvaccinations.location
AND coviddeaths.date = covidvaccinations.date
WHERE coviddeaths.continent IS NOT NULL
ORDER BY 2,3;

-- joining both tables and seeing the ratio of vaccinated to deaths


SELECT coviddeaths.continent, coviddeaths.location, coviddeaths.date, 
SUM(coviddeaths.total_deaths) AS deaths, 
SUM(covidvaccinations.new_vaccinations) AS vaccinated,
SUM(coviddeaths.total_deaths) / SUM(covidvaccinations.new_vaccinations) AS death_to_vaccination_ratio
FROM Portfolio.coviddeaths
JOIN Portfolio.covidvaccinations
ON coviddeaths.location = covidvaccinations.location 
AND coviddeaths.date = covidvaccinations.date
WHERE coviddeaths.continent IS NOT NULL
GROUP BY coviddeaths.continent, coviddeaths.location, coviddeaths.date;
