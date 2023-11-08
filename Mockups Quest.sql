create type "roles" as enum ('admin', 'staff', 'customer');
create type "sizes" as enum ('small', 'medium', 'large');
create type "statuses" as enum ('on-progress', 'delivered', 'canceled', 'ready-to-pick');

create table "users" (
	"id" serial primary key,
	"fullName" varchar(50) not null,
	"email" varchar(50) unique not null,
	"password" varchar(50) not null,
	"address" text,
	"picture" text,
	"phoneNumber" varchar(20),
	"role" "roles" default 'customer',
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "products" (
	"id" serial primary key,
	"name" varchar (30) unique not null,
	"description" text not null,
	"price" numeric(12,2) not null,
	"image" text,
	"discount" float,
	"isRecommended" bool,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "productSize" (
	"id" serial primary key,
	"size" "sizes" default 'small',
	"additionalPrice" numeric (12,2),
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "productVariant" (
	"id" serial primary key,
	"name" varchar(30) unique not null,
	"additionalPrice" numeric (12,2),
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "tags" (
	"id" serial primary key,
	"name" varchar(30) unique not null,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "productRatings" (
	"id" serial primary key,
	"productId" int references "products" ("id"),
	"rate" numeric(1,1) not null,
	"reviewMessage" text,
	"userId" int references "users" ("id"),
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "categories" (
	"id" serial primary key,
	"name" varchar(30) unique not null,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "productCategories" (
	"id" serial primary key,
	"productId" int references "products" ("id"),
	"categoryId" int references "categories" ("id"),
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "promo" (
	"id" serial primary key,
	"name" varchar(30) unique not null,
	"code" varchar(30) unique not null,
	"description" text not null,
	"percentage" bool not null,
	"maximumPromo" numeric(12,2) not null,
	"minimumAmount" numeric(12,2) not null,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "orders" (
	"id" serial primary key,
	"userId" int references "users" ("id"),
	"orderNumber" varchar(30) not null,
	"promoId" int references "promo" ("id"),
	"total" numeric(12,2) not null,
	"taxAmount" numeric (12,2),
	"status" "statuses",
	"deliveryAddress" text not null,
	"fullName" varchar(50) not null,
	"email" varchar(50) not null,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
 );
 
create table "orderDetails" (
	"id" serial primary key,
	"productId" int references "products" ("id"),
	"productSizeId" int references "productSize" ("id"),
	"productVariantId" int references "productVariant" ("id"),
	"quantity" int not null,
	"orderId" int references "orders" ("id"),
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

create table "message" (
	"id" serial primary key,
	"recipientId" int references "users" ("id"),
	"senderId" int references "users" ("id"),
	"text" text not null,
	"createdAt" timestamp default now(),
	"updatedAt" timestamp
);

----------------------------------------------------------------------------------------------------------------

begin;
insert into "users" ("fullName", "email", "password", "address", "phoneNumber") 
values ('Sarah Johnson', 'sarah.johnson@example.com', 'qWErT123', '456 Elm Ave', '082345678901'),
	('David Brown', 'david.brown@example.com', '7sD9F8w', '789 Oak Rd', '083456789012'),
	('Emily Davis', 'emily.davis@example.com', 'tRp2kQs', '101 Pine Ln', '084567890123'),
	('Michael Lee', 'michael.lee@example.com', 'MhK5fjQ', '202 Cedar St', '085678901234'),
	('Jessica Clark', 'jessica.clark@example.com', '1kA3pWx', '303 Birch Dr', '086789012345'),
	('James Taylor', 'james.taylor@example.com', 'hPQ4vN6', '404 Spruce Ct', '087890123456'),
	('Olivia Martinez', 'olivia.martinez@example.com', 'ZcRf6pL', '505 Willow Rd', '088901234567'),
	('Robert Hall', 'robert.hall@example.com', '9sBxT3m', '606 Oakwood Ave', '089012345678'),
	('Sophia White', 'sophia.white@example.com', 'Fg3A4Yi', '707 Maple St', '080123456789'),
	('Daniel Harris', 'daniel.harris@example.com', 'Qw6Y7r2', '808 Birch Ln', '081234567890'),
	('Ava Anderson', 'ava.anderson@example.com', 'P4uJySx', '909 Pine Ave', '082345678901'),
	('William Jackson', 'william.jackson@example.com', 'LpQ9RzS', '110 Cedar Dr', '083456789012'),
	('Mia Harris', 'mia.harris@example.com', '5Xc8zR7', '211 Elm Rd', '084567890123'),
	('Benjamin Johnson', 'benjamin.johnson@example.com', 'GpW2fSv', '313 Spruce St', '085678901234'),
	('Amelia Wilson', 'amelia.wilson@example.com', 'Tm6N7gZ', '414 Willow Ave', '086789012345'),
	('Matthew Adams', 'matthew.adams@example.com', 'H7tK1jR', '515 Oakwood Ct', '087890123456'),
	('Charlotte Turner', 'charlotte.turner@example.com', '3Zs1WpR', '616 Birch Dr', '088901234567'),
	('Ethan Scott', 'ethan.scott@example.com', 'xYs4Vj6', '717 Pine Ln', '089012345678'),
	('Isabella Parker', 'isabella.parker@example.com', 'W1z2MvQ', '818 Cedar Rd', '080123456789'),
	('Samuel Rodriguez', 'samuel.rodriguez@example.com', 'PqFv3Z9', '919 Elm St', '081234567890'),
	('Elizabeth Evans', 'elizabeth.evans@example.com', 'L5sNfVr', '120 Main Ave', '082345678901'),
	('Christopher Moore', 'christopher.moore@example.com', 'Uw7Xy5B', '221 Oak Rd', '083456789012'),
	('Grace Young', 'grace.young@example.com', 'J3sRv6P', '322 Pine Ln', '084567890123'),
	('Joseph Turner', 'joseph.turner@example.com', 'Qk4RzGv', '423 Elm Dr', '085678901234'),
	('Lily Baker', 'lily.baker@example.com', '1YfB5qK', '524 Cedar St', '086789012345'),
	('Andrew Lewis', 'andrew.lewis@example.com', 'V5tRqBj', '625 Birch Ct', '087890123456'),
	('Harper Harris', 'harper.harris@example.com', 'C5vT6jA', '726 Spruce Rd', '088901234567'),
	('Christopher Allen', 'christopher.allen@example.com', '9Kw7GfT', '827 Willow Ave', '089012345678'),
	('Addison Rodriguez', 'addison.rodriguez@example.com', 'S3rWkPz', '928 Oakwood St', '080123456789'),
	('Evelyn Lewis', 'evelyn.lewis@example.com', '6Np4QyT', '29 Cedar Dr', '081234567890'),
	('David Hernandez', 'david.hernandez@example.com', 'Fj5XwTz', '98 Elm Ave', '082345678901'),
	('Abigail Mitchell', 'abigail.mitchell@example.com', '9Lw7QrT', '74 Pine Ln', '083456789012'),
	('Alexander Thomas', 'alexander.thomas@example.com', '4Yn6VpJ', '7 Willow Rd', '084567890123'),
	('Elizabeth Johnson', 'elizabeth.johnson@example.com', 'j4Kx3Sv', '66 Oakwood Ct', '085678901234'),
	('Daniel Wright', 'daniel.wright@example.com', 'H2fNcQr', '13 Main St', '086789012345'),
	('Chloe Turner', 'chloe.turner@example.com', 'q8RfSv1', '28 Elm Rd', '087890123456'),
	('William Lopez', 'william.lopez@example.com', 'B1sTm9R', '83 Cedar Dr', '088901234567'),
	('Sofia Davis', 'sofia.davis@example.com', '4LxQfYr', '12 Oak Rd', '089012345678'),
	('Henry Adams', 'henry.adams@example.com', 'Yp3Rz1G', '78 Pine Ave', '080123456789'),
	('Victoria Perez', 'victoria.perez@example.com', 'V2yLsRq', '34 Willow Dr', '081234567890'),
	('Samuel White', 'samuel.white@example.com', '1Hc3SfR', '62 Spruce St', '082345678901'),
	('Madison Nelson', 'madison.nelson@example.com', '3JwR5vS', '47 Birch Rd', '083456789012'),
	('Joseph Miller', 'joseph.miller@example.com', 'L8tRwVp', '9 Pine Ln', '084567890123'),
	('Charlotte Jackson', 'charlotte.jackson@example.com', 'J6wBvQy', '42 Elm Ct', '085678901234'),
	('James Harris', 'james.harris@example.com', 'Z8qFvXk', '25 Willow Ave', '086789012345'),
	('Mia Thompson', 'mia.thompson@example.com', '1Pc9XvM', '33 Oakwood Rd', '087890123456');
	
-----------------------------------------------------------------------------------------------------------------

	insert into "products" ("name", "description", "price", "isRecommended")
	values ('Cappuccino', 'A classic Italian coffee with espresso, steamed milk, and foam', 25000, true),
	('Mocha', 'A luscious combination of espresso, chocolate, and milk', 32000, true),
	('Americano', 'A simple yet strong black coffee made from espresso and water', 22000, false),
	('Macchiato', 'Espresso stained with a small amount of frothy milk', 26000, false),
	('Iced Coffee', 'Chilled coffee served with ice and optionally, cream and sugar', 27000, true),
	('Turkish Coffee', 'Finely ground coffee beans simmered with water and cardamom', 25000, false),
	('Cold Brew', 'Coffee brewed with cold water for a smooth and less acidic taste', 32000, true),
	('Irish Coffee', 'Hot coffee with Irish whiskey, sugar, and a layer of cream', 35000, false),
	('Caramel Macchiato', 'Espresso with caramel syrup, steamed milk, and foam', 34000, true),
	('Affogato', 'Espresso poured over a scoop of vanilla ice cream', 28000, true),
	('French Press Coffee', 'Coarsely ground coffee steeped in hot water and pressed', 28000, false),
	('Iced Caramel Latte', 'Iced latte with caramel syrup, milk, and espresso', 36000, true),
	('Flat White', 'Espresso with steamed milk and a velvety microfoam', 32000, true),
	('Decaf Coffee', 'Coffee with the caffeine removed for a milder taste', 24000, false),
	('Cortado', 'Espresso "cut" with a small amount of warm milk', 30000, false),
	('Ethiopian Yirgacheffe', 'Single-origin coffee with fruity and floral notes', 38000, true),
	('Ristretto', 'An even shorter and more concentrated shot of espresso', 26000, false),
	('Vietnamese Coffee', 'Strong coffee with sweetened condensed milk', 26000, true),
	('Margherita Pizza', 'Thin-crust pizza with tomato sauce, mozzarella cheese, and fresh basil', 45000, false),
	('Caesar Salad', 'Fresh romaine lettuce, Caesar dressing, croutons, and Parmesan cheese', 35000, true),
	('Spaghetti Bolognese', 'Spaghetti pasta with rich meat sauce and Parmesan cheese', 40000, true),
	('Iced Tea', 'Refreshing iced tea with a hint of lemon', 15000, true),
	('Veggie Burger', 'A delicious vegetarian burger with lettuce, tomato, and special sauce', 35000, false),
	('Chocolate Brownie', 'A warm and gooey chocolate brownie', 20000, false),
	('Chicken Quesadilla', 'Grilled chicken and melted cheese in a tortilla', 30000, false),
	('Fruit Smoothie', 'Blend of fresh fruits, yogurt, and honey', 25000, true),
	('Club Sandwich', 'Triple-decker sandwich with turkey, bacon, lettuce, and tomato', 40000, false),
	('Fish and Chips', 'Crispy fish fillets with fries and tartar sauce', 45000, true),
	('Espresso', 'A strong and aromatic shot of espresso', 15000, false),
	('Caprese Salad', 'Fresh tomatoes, mozzarella, basil, and balsamic glaze', 35000, true),
	('Beef Burrito', 'Flour tortilla filled with seasoned beef, rice, beans, and salsa', 35000, false),
	('Chicken Alfredo', 'Fettuccine pasta with creamy Alfredo sauce and grilled chicken', 40000, true),
	('Iced Latte Coffee', 'Chilled coffee with milk and sweetener', 20000, true),
	('Spinach and Artichoke Dip', 'Creamy dip with spinach, artichokes, and melted cheese', 30000, false),
	('Tuna Salad', 'Tuna, mixed greens, olives, and vinaigrette dressing', 35000, true),
	('Hawaiian Pizza', 'Pizza with ham, pineapple, and mozzarella cheese', 45000, true),
	('Strawberry Cheesecake', 'Creamy cheesecake with fresh strawberries', 25000, false),
	('Vegetable Stir-Fry', 'Mixed vegetables stir-fried in a savory sauce', 35000, true),
	('Chai Latte', 'Spiced tea latte with steamed milk and honey', 25000, true),
	('BBQ Ribs', 'Slow-cooked ribs with BBQ sauce and coleslaw', 45000, false),
	('Nachos', 'Tortilla chips topped with melted cheese, jalapeños, and salsa', 30000, true),
	('Chicken Noodle Soup', 'Classic chicken soup with noodles and vegetables', 35000, false),
	('Pancakes', 'Fluffy pancakes with maple syrup and butter', 25000, true),
	('Beef Tacos', 'Soft tortillas filled with seasoned beef, lettuce, and salsa', 35000, true),
	('Greek Salad', 'Cucumber, tomatoes, olives, feta cheese, and Greek dressing', 30000, false),
	('Chocolate Milkshake', 'Creamy chocolate shake with whipped cream', 20000, false),
	('Shrimp Scampi', 'Shrimp cooked in garlic and butter sauce over pasta', 40000, false),
	('French Fries', 'Crispy and golden French fries', 15000, false),
	('Miso Soup', 'Traditional Japanese soup with tofu and seaweed', 20000, true),
	('BLT Sandwich', 'Bacon, lettuce, tomato, and mayo on toasted bread', 35000, true),
	('Capuccino', 'A classic Italian coffee with espresso, steamed milk and foam', 25000, true),
	('Garden Salad', 'Fresh mixed greens with a variety of vegetables and dressing', 30000, false),
	('Sushi Roll', 'Assorted sushi rolls with soy sauce and wasabi', 40000, false),
	('Chicken Wings', 'Crispy chicken wings with your choice of sauce', 35000, true),
	('Croissant', 'Buttery and flaky croissant', 15000, false),
	('Beef Stroganoff', 'Sliced beef in a creamy mushroom sauce over egg noodles', 45000, true),
	('Tiramisu', 'Classic Italian dessert with coffee-soaked ladyfingers', 25000, false),
	('Egg Fried Rice', 'Fried rice with eggs, vegetables, and soy sauce', 35000, false),
	('Milk Tea', 'Creamy milk tea with boba pearls', 25000, true),
	('Baked Potato', 'Baked potato topped with sour cream, cheese, and chives', 30000, true),
	('Sausage and Peppers', 'Sausages and bell peppers in a savory tomato sauce', 40000, false),
	('Fajitas', 'Grilled chicken or steak with sautéed onions and peppers', 35000, true),
	('Pumpkin Soup', 'Creamy pumpkin soup with a touch of nutmeg', 20000, false),
	('Mashed Potatoes', 'Creamy mashed potatoes with gravy', 25000, true),
	('Fruit Salad', 'Fresh fruit salad with a honey-lime dressing', 30000, true),
	('Pulled Pork Sandwich', 'Slow-cooked pulled pork with BBQ sauce on a bun', 35000, false),
	('Green Tea Ice Cream', 'Matcha-flavored ice cream', 20000, true);

------------------------------------------------------------------------------------------------------------------------------------
	
	insert into "categories" ("name")
	values ('coffee'), ('non coffee'), ('food');

------------------------------------------------------------------------------------------------------------------------------------

	insert into "productCategories" ("productId", "categoryId")
	values (1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1),
	(10, 1),
	(11, 1),
	(12, 1),
	(13, 1),
	(14, 1),
	(15, 1),
	(16, 1),
	(17, 1),
	(18, 1),
	(19, 3),
	(10, 3),
	(11, 3),
	(12, 2),
	(13, 3),
	(14, 3),
	(15, 3),
	(16, 2),
	(17, 3),
	(18, 3),
	(19, 3),
	(20, 1),
	(21, 3),
	(22, 3),
	(23, 2),
	(24, 3),
	(25, 3),
	(26, 3),
	(27, 3),
	(28, 3),
	(29, 3),
	(30, 1),
	(31, 3),
	(32, 3),
	(33, 2),
	(34, 3),
	(35, 3),
	(36, 3),
	(37, 3),
	(38, 3),
	(39, 2),
	(40, 3),
	(41, 2),
	(42, 3),
	(43, 3),
	(44, 2),
	(45, 3),
	(46, 3),
	(47, 3),
	(48, 3),
	(49, 3),
	(50, 3),
	(51, 1),
	(52, 3),
	(53, 3),
	(54, 3),
	(55, 3),
	(56, 3),
	(57, 1),
	(58, 3),
	(59, 3),
	(60, 2),
	(61, 3),
	(62, 3),
	(63, 3),
	(64, 3),
	(65, 3),
	(66, 2),
	(67, 3);
end;



