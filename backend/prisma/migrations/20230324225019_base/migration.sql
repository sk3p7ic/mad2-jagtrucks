-- CreateEnum
CREATE TYPE "SocialProviderType" AS ENUM ('PERSONAL', 'SOCIAL_MEDIA');

-- CreateTable
CREATE TABLE "SocialProvider" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "baseUrl" TEXT NOT NULL,
    "providerType" "SocialProviderType" NOT NULL,

    CONSTRAINT "SocialProvider_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TruckSocial" (
    "id" TEXT NOT NULL,
    "handle" TEXT,
    "providerId" TEXT NOT NULL,
    "truckId" TEXT NOT NULL,

    CONSTRAINT "TruckSocial_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FoodTruck" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "imagePath" TEXT,
    "foodGenreId" TEXT NOT NULL,
    "acceptsDiningDollars" BOOLEAN NOT NULL,
    "menu" JSON NOT NULL,

    CONSTRAINT "FoodTruck_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScheduleEntry" (
    "id" TEXT NOT NULL,
    "startDate" TIMESTAMP NOT NULL,
    "endDate" TIMESTAMP NOT NULL,
    "truckId" TEXT NOT NULL,
    "locationId" TEXT NOT NULL,

    CONSTRAINT "ScheduleEntry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LocationEntry" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,

    CONSTRAINT "LocationEntry_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "SocialProvider_name_key" ON "SocialProvider"("name");

-- AddForeignKey
ALTER TABLE "TruckSocial" ADD CONSTRAINT "TruckSocial_providerId_fkey" FOREIGN KEY ("providerId") REFERENCES "SocialProvider"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TruckSocial" ADD CONSTRAINT "TruckSocial_truckId_fkey" FOREIGN KEY ("truckId") REFERENCES "FoodTruck"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScheduleEntry" ADD CONSTRAINT "ScheduleEntry_truckId_fkey" FOREIGN KEY ("truckId") REFERENCES "FoodTruck"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScheduleEntry" ADD CONSTRAINT "ScheduleEntry_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "LocationEntry"("id") ON DELETE CASCADE ON UPDATE CASCADE;
