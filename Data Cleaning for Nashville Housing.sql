-- Cleaning Data in SQL Queries
Select *
From PortfolioProject..NashvilleHousing


-- Standardize Date Format

Select SaleDate, CONVERT(Date,SaleDate)
From PortfolioProject..NashvilleHousing

Update NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;
Update NashvilleHousing
Set SaleDateConverted = CONVERT(Date,SaleDate)

Select SaleDateConverted
From PortfolioProject..NashvilleHousing
---------------------------------------------------------------------------------------------

-- Populate Property Address Data
Select *
From PortfolioProject..NashvilleHousing
--Where PropertyAddress is null
order by ParcelID

--PropertAddress eksik ParcelID'leri aynýysa PropertAddress'i de ona atadýk.
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

--Isnull a.PropertyAddress boþ ise b.PropertyAddress ile doldur dedik.
Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)
Select PropertyAddress
From PortfolioProject..NashvilleHousing

-- Adrese git 1.deðerden baþla virgüle kadar git. (-1 yapmamýzýn sebebi virgülü istemememiz.)
-- +1 yapmamýzýn sebebi ise baþýnda virgül olmasýn diye.
-- LEN(PropertyAddress) ise uzunluðunu aldýk sona kadr gitmesi için.
SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
,SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
From PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);
Update NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);
Update NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


-- 2. YOL :
Select OwnerAddress 
From PortfolioProject..NashvilleHousing

-- PARSENAME noktalarla kullanýþlýdýr.
-- Bu yüzden virgülleri noktalara çeviriyoruz.
Select 
PARSENAME(REPLACE(OwnerAddress, ',','.'),3),
PARSENAME(REPLACE(OwnerAddress, ',','.'),2),
PARSENAME(REPLACE(OwnerAddress, ',','.'),1)
From PortfolioProject..NashvilleHousing


ALTER TABLE NashvilleHousing
Add OwnerSplitAdress Nvarchar(255);
Update NashvilleHousing
Set OwnerSplitAdress = PARSENAME(REPLACE(OwnerAddress, ',','.'),3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);
Update NashvilleHousing
Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',','.'),2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);
Update NashvilleHousing
Set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',','.'),1)

Select * 
From PortfolioProject..NashvilleHousing


-------------------------------------------------------------------------------------------------

-- CHANGE Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(soldAsVacant), Count(SoldAsVacant)
From PortfolioProject..NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant,
	Case When SoldAsVacant = 'Y' Then 'Yes'
		 When SoldAsVacant = 'N' Then 'No'
		 ELSE SoldAsVacant 
		 END
From PortfolioProject..NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = 
	Case When SoldAsVacant = 'Y' Then 'Yes'
		 When SoldAsVacant = 'N' Then 'No'
		 ELSE SoldAsVacant 
	END
From PortfolioProject..NashvilleHousing

----------------------------------------------------------------------------------------------

-- Remove Duplicates
WITH RowNumCTE AS (
Select *,
	ROW_NUMBER() OVER ( 
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY 
				    UniqueID
					) row_num
From PortfolioProject..NashvilleHousing
)
--DELETE
Select *
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress

--------------------------------------------------------------------------------------------

-- Delete Unused Columns

Select * 
From PortfolioProject..NashvilleHousing

AlTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress


AlTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN SaleDate