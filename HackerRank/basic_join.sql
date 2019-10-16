-----Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

---Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

select city.name 
from city join country
on city.countrycode = country.code
where country.continent = 'Africa';

-----Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city 
--populations (CITY.Population) rounded down to the nearest integer.

select country.continent, floor(avg(city.population))
from city join country
on city.countrycode = country.code
group by country.continent;
-----Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in 
 --descending order by grade -- i.e. higher grades are entered first. If there is more than one 
  --student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, 
  --if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one 
  --student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.    
SELECT CASE WHEN Grade < 8 THEN NULL
            ELSE Name 
            END AS Name,
       Grade, Marks
FROM Students, Grades
WHERE Marks BETWEEN Min_Mark AND Max_Mark
ORDER BY Grade DESC, Name, Marks;
