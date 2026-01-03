# National-Park-db
Creating a relational database for Glacier National Park to analyze endangered species

## Data
The database describes the biodiversity of non-plant lifeforms in Glacier National Park.  It includes attributes of species, which include taxonomy, extinction status, conservation status native status, activity, ecological roles, and more. 

### Scope
First, I cleaned the original dataset from kaggle: 
- Eliminated all plant life forms
- Focused on one national park instead of many: Glacier National Park
- Removed the “state rarity rank” column

Fitted the cleaned data in excel. 

## Database Design
I mapped out the tables by hand and created the ERD in MySQL Workbench. 

Main table: Animals 
- Animals_id (PK)
- Common_name
- Scientific_name 
- Species_id (FK)
- Activity_id (FK)
- Present_id (FK)
- Native_id (FK)
- Rarity_id (FK)
- Role_id (FK)
- Approval_id (FK)
- Global_rank_id (FK)
- Evidence_id (FK)
- TE_status_id (FK)

Other tables:

Evidence

Approvals

Activity

Species

Presence

Threat_Status 

Native

Roles

Global_ranks

Rarities

## Stored Programs 

Count_by_role

add_animal

migratory_species

rarity_by_spec_categ



