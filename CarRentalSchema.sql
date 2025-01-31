CREATE TABLE "Persons"(
    "PersonID" INT NOT NULL,
    "FirstName" NVARCHAR(50) NOT NULL,
    "LastName" NVARCHAR(50) NOT NULL,
    "BirthDate" DATE NOT NULL,
    "Gender" CHAR(1) NOT NULL,
    "Email" NVARCHAR(50) NOT NULL,
    "Phone" NVARCHAR(20) NOT NULL,
    "CreatedAt" TIMESTAMP NOT NULL,
    "UpdatedAt" TIMESTAMP NOT NULL
);
ALTER TABLE
    "Persons" ADD CONSTRAINT "persons_personid_primary" PRIMARY KEY("PersonID");
CREATE UNIQUE INDEX "persons_email_unique" ON
    "Persons"("Email");
CREATE UNIQUE INDEX "persons_phone_unique" ON
    "Persons"("Phone");
CREATE TABLE "Customers"(
    "CustomerID" INT NOT NULL,
    "DriverLicence" NVARCHAR(255) NOT NULL,
    "CreatedAt" TIMESTAMP NOT NULL,
    "UpdatedAt" TIMESTAMP NOT NULL,
    "PersonID" INT NOT NULL
);
ALTER TABLE
    "Customers" ADD CONSTRAINT "customers_customerid_primary" PRIMARY KEY("CustomerID");
CREATE TABLE "Vehicles"(
    "VehicleID" INT NOT NULL,
    "Brand" NVARCHAR(50) NOT NULL,
    "Model" NVARCHAR(30) NOT NULL,
    "Year" INT NOT NULL,
    "Mileage" SMALLINT NOT NULL,
    "FuelTypeID" INT NOT NULL,
    "PlateNumber" NVARCHAR(20) NOT NULL,
    "VehicleCategoryID" INT NOT NULL,
    "RentalPricePerDay" DECIMAL(8, 2) NOT NULL,
    "IsAvailable" BIT NOT NULL
);
ALTER TABLE
    "Vehicles" ADD CONSTRAINT "vehicles_vehicleid_primary" PRIMARY KEY("VehicleID");
CREATE UNIQUE INDEX "vehicles_platenumber_unique" ON
    "Vehicles"("PlateNumber");
CREATE TABLE "Bookings"(
    "BookID" INT NOT NULL,
    "CustomerID" INT NOT NULL,
    "VehicleID" INT NOT NULL,
    "RentalStartDate" DATE NOT NULL,
    "RentalEndDate" DATE NOT NULL,
    "PickupLocation" NVARCHAR(100) NOT NULL,
    "DropOffLocation" NVARCHAR(100) NOT NULL,
    "InitialRentalDays" SMALLINT NOT NULL,
    "InitialPricePerDay" DECIMAL(8, 2) NOT NULL,
    "InitialTotalDueAmount" DECIMAL(8, 2) NOT NULL,
    "InitialCheckNotes" NVARCHAR(255) NOT NULL
);
ALTER TABLE
    "Bookings" ADD CONSTRAINT "bookings_bookid_primary" PRIMARY KEY("BookID");
CREATE TABLE "Transactions"(
    "TransactionID" INT NOT NULL,
    "BookID" INT NOT NULL,
    "ReturnID" INT NOT NULL,
    "PaymentDetails" NVARCHAR(100) NOT NULL,
    "PaidInitialTotalDueAmount" DECIMAL(8, 2) NOT NULL,
    "ActualTotalDueAmount" DECIMAL(8, 2) NULL,
    "TotalRemaining" DECIMAL(8, 2) NULL,
    "TotalRefundedAmount" DECIMAL(8, 2) NULL,
    "TransactionDate" DATETIME NOT NULL,
    "UpdatedTransactionDate" DATETIME NOT NULL
);
ALTER TABLE
    "Transactions" ADD CONSTRAINT "transactions_transactionid_primary" PRIMARY KEY("TransactionID");
CREATE TABLE "Returns"(
    "ReturnID" INT NOT NULL,
    "ActualReturnDate" DATETIME NOT NULL,
    "ActualRentalDays" SMALLINT NOT NULL,
    "Mileage" SMALLINT NOT NULL,
    "ConsumedMileage" SMALLINT NOT NULL,
    "FinalCheckNotes" NVARCHAR(500) NOT NULL,
    "AdditionalCharges" DECIMAL(8, 2) NULL,
    "ActualTotalDueAmount" DECIMAL(8, 2) NOT NULL
);
ALTER TABLE
    "Returns" ADD CONSTRAINT "returns_returnid_primary" PRIMARY KEY("ReturnID");
CREATE TABLE "FuelTypes"(
    "ID" INT NOT NULL,
    "FuelType" NVARCHAR(20) NOT NULL
);
ALTER TABLE
    "FuelTypes" ADD CONSTRAINT "fueltypes_id_primary" PRIMARY KEY("ID");
CREATE TABLE "VehicleCategories"(
    "CategoryID" INT NOT NULL,
    "CategoryName" NVARCHAR(30) NOT NULL
);
ALTER TABLE
    "VehicleCategories" ADD CONSTRAINT "vehiclecategories_categoryid_primary" PRIMARY KEY("CategoryID");
CREATE TABLE "Maintenance"(
    "MaintenanceID" INT NOT NULL,
    "VehicleID" INT NOT NULL,
    "Description" TEXT NOT NULL,
    "MaintenanceDate" DATE NOT NULL,
    "Cost" DECIMAL(8, 2) NOT NULL
);
ALTER TABLE
    "Maintenance" ADD CONSTRAINT "maintenance_maintenanceid_primary" PRIMARY KEY("MaintenanceID");
ALTER TABLE
    "Vehicles" ADD CONSTRAINT "vehicles_vehiclecategoryid_foreign" FOREIGN KEY("VehicleCategoryID") REFERENCES "VehicleCategories"("CategoryID");
ALTER TABLE
    "Vehicles" ADD CONSTRAINT "vehicles_fueltypeid_foreign" FOREIGN KEY("FuelTypeID") REFERENCES "FuelTypes"("ID");
ALTER TABLE
    "Transactions" ADD CONSTRAINT "transactions_bookid_foreign" FOREIGN KEY("BookID") REFERENCES "Bookings"("BookID");
ALTER TABLE
    "Transactions" ADD CONSTRAINT "transactions_returnid_foreign" FOREIGN KEY("ReturnID") REFERENCES "Returns"("ReturnID");
ALTER TABLE
    "Customers" ADD CONSTRAINT "customers_personid_foreign" FOREIGN KEY("PersonID") REFERENCES "Persons"("PersonID");
ALTER TABLE
    "Bookings" ADD CONSTRAINT "bookings_vehicleid_foreign" FOREIGN KEY("VehicleID") REFERENCES "Vehicles"("VehicleID");
ALTER TABLE
    "Maintenance" ADD CONSTRAINT "maintenance_vehicleid_foreign" FOREIGN KEY("VehicleID") REFERENCES "Vehicles"("VehicleID");
ALTER TABLE
    "Bookings" ADD CONSTRAINT "bookings_customerid_foreign" FOREIGN KEY("CustomerID") REFERENCES "Customers"("CustomerID");