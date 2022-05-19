-- Задача 1
SELECT name 
FROM Pilots
WHERE Pilots.pilot_id IN (
    SELECT DISTINCT seccond_pilot_id FROM Flights
    WHERE flight_dt_y = 2022 AND flight_dt_m = 8 AND destination = 'Шереметьево'
    GROUP BY (seccond_pilot_id)
    HAVING COUNT(flight_id)  = 3
)


-- Задача 2
SELECT Pilots.name
FROM Pilots
WHERE Pilots.age > 45
AND Pilots.pilot_id IN 
    (SELECT Flights.first_pilot_id 
    FROM Flights INNER JOIN Planes 
    ON Flights.plane_id = Planes.plane_id
    WHERE Planes.capacity > 30
    AND Planes.cargo_flg = 0
    UNION 
    SELECT Flights.seccond_pilot_id 
    FROM Flights INNER JOIN Planes 
    ON Flights.plane_id = Planes.plane_id
        WHERE Planes.capacity > 30
    AND Planes.cargo_flg = 0)
    

-- Задача 3
SELECT name 
FROM Pilots INNER JOIN Flights ON Pilots.pilot_id = Flights.first_pilot_id
            INNER JOIN Planes ON Planes.plane_id = Flights.plane_id
WHERE cargo_flg = 1 AND flight_dt_y = 2022
GROUP BY pilot_id
ORDER BY COUNT(flight_id)
LIMIT 10;
