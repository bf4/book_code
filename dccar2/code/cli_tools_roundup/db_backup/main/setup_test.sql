drop database if exists backup_test;
create database backup_test;
use backup_test;

create table test_table(
    id int,
    name varchar(255)
);

insert into test_table(id,name) values (1,'Dave'), (2, 'Amy'), (3,'Rudy');
