-- mysql -uadmin -padmin < change_mymemory.sql

USE `matecat`;

UPDATE engines 
SET name = 'parrot',
    base_url = 'http://parrot:8080'
WHERE id = 1;