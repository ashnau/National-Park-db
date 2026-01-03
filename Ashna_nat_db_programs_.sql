#Ashna's stored programs 

#4 - Function, counts all the animals of a certain role 

DROP FUNCTION IF EXISTS count_by_role;

DELIMITER //

CREATE FUNCTION count_by_role(role_name_input VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE role_count INT;

    SELECT COUNT(*) INTO role_count
    FROM animals 
    JOIN roles ON animals.role_id = roles.role_id
    WHERE roles.role = role_name_input;

    RETURN role_count;
END //

DELIMITER ;

#Test function counts by migratory
SELECT count_by_role('migratory');

#3 procedure, adds animal to database  

DROP PROCEDURE IF EXISTS add_animal;

DELIMITER //

CREATE PROCEDURE add_animal(
    IN p_animals_id INT,
    IN p_common_name VARCHAR(255),
    IN p_scientific_name VARCHAR(255),
    IN p_species_id INT,
    IN p_activity_id INT,
    IN p_present_id INT,
    IN p_native_id INT,
    IN p_rarity_id INT,
    IN p_role_id INT,
    IN p_approval_id INT,
    IN p_global_rank_id INT,
    IN p_evidence_id INT,
    IN p_TE_status_id INT
)
BEGIN
    INSERT INTO animals (
        animals_id,
        common_name,
        scientific_name,
        species_id,
        activity_id,
        present_id,
        native_id,
        rarity_id,
        role_id,
        approval_id,
        global_rank_id,
        evidence_id,
        TE_status_id
    )
    VALUES (
        p_animals_id,
        p_common_name,
        p_scientific_name,
        p_species_id,
        p_activity_id,
        p_present_id,
        p_native_id,
        p_rarity_id,
        p_role_id,
        p_approval_id,
        p_global_rank_id,
        p_evidence_id,
        p_TE_status_id
    );
END //

DELIMITER ;

#Test procedure adds Red-tailed Hawk

CALL add_animal(
    886,
    'Red-tailed Hawk',
    'Buteo jamaicensis',
    12,
    2,
    1,
    1,
    2,
    2,
    2,
    3,
    1,
    3
);
#2 View, shows the common name, role, and category for animals that have the migratory role 
USE nat_park_db;

CREATE VIEW migratory_species AS
SELECT 
    a.common_name,
    r.role,
    s.Species_category
FROM animals a
JOIN roles r 
    ON a.role_id = r.role_id
JOIN species s
    ON a.species_id = s.species_id
WHERE r.role = 'migratory';




#1 View, Shows the avg rarity by species category of the least abundant animals (animals that are present less than average amount)

USE nat_park_db;

DROP VIEW IF EXISTS rarity_by_spec_categ;

CREATE VIEW rarity_by_species AS
SELECT 
    s.Species_category,
    ROUND(AVG(a.rarity_id), 2) AS Avg_rarity
FROM animals a
JOIN Species s ON a.Species_id = s.Species_id
GROUP BY s.species_category
HAVING COUNT(*) < (
    SELECT AVG(category_count)
    FROM (
        SELECT COUNT(*) AS category_count
        FROM animals a2
        JOIN Species s2 ON a2.Species_id = s2.Species_id
        GROUP BY s2.species_category
	
    ) t
);




