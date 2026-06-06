-- Backfill any null itemName from the dropped category, then enforce NOT NULL
UPDATE "ItemDonation" SET "itemName" = COALESCE("itemName", "category"::text);

-- DropColumn (removes ItemDonation.category)
ALTER TABLE "ItemDonation" DROP COLUMN "category";

-- DropEnum
DROP TYPE "ItemCategory";

-- Make itemName required (it must come from campaign.acceptedItems going forward)
ALTER TABLE "ItemDonation" ALTER COLUMN "itemName" SET NOT NULL;
