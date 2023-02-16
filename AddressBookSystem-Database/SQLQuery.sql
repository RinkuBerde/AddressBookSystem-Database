-- Welcome to the Address Book System-Database
--UC01- Create Address Book database
create database Address_Book
use Address_Book
----UC 2: Create Table----
create table AddressBookDetails(
firstName varchar(200) not null,
lastName varchar(200) not null,
address varchar(255) not null,
city varchar(255),
state varchar(255),
zip int,
phoneNumber bigint,
email varchar(200) not null
)

------ UC 3: Insert Values to Table ------
insert into  AddressBookDetails
values('rinku', 'berde', '54 backstreet', 'NY', 'America', 123654, 09876557843, 'rinku@email.com'),
('gitesh', 'kumar', '12 SM nagar', 'Mysore', 'Karnataka', 100004, 09876554322, 'gitesh@email.com'),
('terisa', 'sharma', '3 AB nagar', 'Noida', 'UP', 543201, 09876552321, 'terisa@email.com'),
('harsha', 'yadav', '84 MJ nagar', 'Chennai', 'Tamil Nadu', 129123, 09876554367, 'harsha@email.com')

--display table
select * from AddressBookDetails

----UC4 ability to edit existing contact using their name---
update AddressBookDetails set phoneNumber=9432667788 where firstName='harsha'

--UC5 ability to delete existing contact using their name--
delete from AddressBookDetails where firstName='terisa'

--UC6 -- ability to retrieve person using city or state from the table
select * from AddressBookDetails where city = 'Mysore' or state = 'karnataka'

------ UC 7: Ability to Retrieve Count of address book by city and state---
select Count(city) from AddressBookDetails
select count(state) from AddressBookDetails

--UC8 Sort Contacts By Name in a City
select * from AddressBookDetails 
WHERE city = 'Chennai'
ORDER BY firstName

------ UC 9: Identify each Address Book with name andType ------
alter table AddressBookDetails 
add Book_Name VARCHAR(20),
Contact_Type VARCHAR(20)

--Update values for Type=Friends--
update AddressBookDetails
set Book_Name='FriendName',Contact_Type='Friends'
where FirstName='harsha' 

--Update values for Type=Family--
update AddressBookDetails
set Book_Name='FamilyName',Contact_Type='Family'
where FirstName='rinku'

--Update values for Type=Profession--
update AddressBookDetails
set Book_Name='Manager',Contact_Type='Profession'
where FirstName='gitesh'
select * from AddressBookDetails

------ UC 10: Ability to get number of contact persons by Type------
select Count(*) as NumberOfContacts,Contact_Type
from  AddressBookDetails
Group by Contact_Type

-------- Creating Tables Based on ER Diagrams  --------
create table Address_Book
(
Address_BookID int identity(1,1) primary key,
Address_BookName varchar(200)
)
insert into Address_Book values ('Ashs Book'),('Priyankas Book')
select * from Address_Book

---- Create Contact_Person Table
create table Contact_Person(
AddressBook_ID int,
Contact_ID int identity(1,1) primary key,
FirstName varchar(100),
SecondName varchar(100),
Address varchar(250),
City varchar(100),
State varchar(100),
zip BigInt,
PhoneNumber BigInt,
Email varchar(200),
foreign key (AddressBook_ID) references Address_Book(Address_BookID))

   --- insert value in Contact_Person table
insert into Contact_Person values
(1,'Rinku','Berde','645 Catherine Street','Bangalore','Karnataka',243001,9842905050,'rinku@gmail.com'),
(2,'Ketan', 'Kumar','836 Heritage Rd','Chennai','Tamil Nadu',134002,98402000,'ketan@gmail.com'),
(2,'Yukta','Yadav','19 Augusta Avenue','Lucknow','Uttar Pradesh',113201,87210505053,'yukta@gmail.com'),
(1,'Pramela','Mane','356 Newburgh','Bangalore','Karnataka',243001,9842905050,'pramela@gmail.com')

select * from Contact_Person

 --- Create table for ContactType
create table ContactType
(ContactType_ID int identity(1,1) primary key,
ContactType_Name varchar(200)
)
--insert values in  ContactType table
insert into ContactType values
('Family'),('Friends'),('Profession')
select * from ContactType

  --- Create table for TypeManager 
create Table TypeManager(
ContactType_Identity int,
Contact_Identity int,
foreign key (ContactType_Identity) references ContactType(ContactType_ID),
foreign key (Contact_Identity) references Contact_Person(Contact_ID)
)
-- insert values in  TypeManager table
insert into TypeManager values
(1,3),
(2,3),
(3,1),
(1,2),
(2,4)
select * from TypeManager

------ UseCase 11: Create Contact for both Family and Friends Type ------ 
select Address_BookName,Concat(FirstName,' ',SecondName) as Name,Concat(Address,' ,',City,' ,',State,' ,',zip) as Address,PhoneNumber,Email,ContactType_Name
from Address_Book 
Full JOIN Contact_Person on Address_Book.Address_BookID=AddressBook_ID 
Full JOIN TypeManager on TypeManager.Contact_Identity=Contact_ID
Full JOIN ContactType on TypeManager.ContactType_Identity=ContactType_ID
