create schema pet_store;

--
-- category
--
create table pet_store.category (
 id bigint primary key
 ,name varchar(30) not null
 ,description varchar(1000) not null
);

--
-- product
--
create table pet_store.product (
 id bigint primary key
 ,name varchar(30) not null
 ,description varchar(1000) not null
 ,category_fk bigint not null
 ,foreign key (category_fk) references pet_store.category(id)
);

--
-- manufacturer
--
create table pet_store.manufacturer (
 id bigint primary key
 ,name varchar(100) not null
);

--
-- item 
--
create table pet_store.item (
 id bigint primary key
 ,name varchar(50) not null
 ,description varchar(3000) not null
 ,unit_cost double not null
 ,product_fk bigint not null
 ,manufacturer_fk bigint
 ,foreign key (product_fk) references pet_store.product(id)
 ,foreign key (manufacturer_fk) references pet_store.manufacturer(id)
);

--
-- warehouse 
--
create table pet_store.warehouse (
 id bigint primary key
 ,name varchar(50) not null
 ,location_point_geojson varchar not null
);

--
-- item_inventory
--
create table pet_store.item_inventory(
 item_fk bigint
 ,warehouse_fk bigint
 ,amount integer not null
 ,inventory_date date
 ,primary key (item_fk,warehouse_fk)
);

--
-- order_line
--
create table pet_store.order_line(
 id bigint primary key
 ,quantity integer not null
 ,item_fk bigint not null
 ,foreign key (item_fk) references pet_store.item(id)
);

--
-- customer
--
create table pet_store.customer(
 id bigint primary key
 ,firstname varchar(100) not null
 ,lastname varchar(100) not null
 ,email varchar(100)
 ,birth_date date
 ,age integer
 ,address_point_geojson varchar 
--    private Address homeAddress = new Address();
);

--
-- customer_order
--
create table pet_store.customer_order (
    id bigint primary key
    ,order_date date 
    ,customer_fk bigint not null
    ,foreign key (customer_fk) references customer(id)
    -- address
    -- credit card
);

--
-- customer_order
--
create table pet_store.customer_order_order_line (
  order_fk bigint
  ,order_line_fk bigint
  ,primary key (order_fk,order_line_fk)
  ,foreign key (order_fk) references pet_store.customer_order(id)
  ,foreign key (order_line_fk) references pet_store.order_line(id)
);