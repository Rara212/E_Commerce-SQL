-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 29, 2021 at 01:56 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e_commerce`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPenjual` (IN `paramNama` VARCHAR(25), IN `paramAlamat_Email` VARCHAR(50), IN `paramNo_Telp` VARCHAR(25), IN `paramAlamat` VARCHAR(50))  BEGIN
	INSERT INTO penjual (Nama, Alamat_Email, No_Telp, Alamat)
    Value (paramNama, paramAlamat_Email, paramNo_Telp, paramAlamat);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Invoice` ()  BEGIN
	SELECT * FROM invoice;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateStatusStruk` (IN `paramID_Struk` INT, IN `paramStatus` VARCHAR(25))  BEGIN
	UPDATE struk set Status_Pembayaran = paramStatus WHERE ID_Struk = paramID_Struk;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `history_pesanan`
--

CREATE TABLE `history_pesanan` (
  `No_Invoice` int(11) NOT NULL,
  `No_Pesanan` int(11) DEFAULT NULL,
  `Tanggal_Order` date DEFAULT NULL,
  `Status_Pesanan` varchar(50) NOT NULL,
  `Waktu` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `history_pesanan`
--

INSERT INTO `history_pesanan` (`No_Invoice`, `No_Pesanan`, `Tanggal_Order`, `Status_Pesanan`, `Waktu`) VALUES
(6001, NULL, NULL, 'PAID', '2021-12-25'),
(0, 5007, NULL, 'On Process', '2021-12-25'),
(0, 5006, NULL, 'On Process', '2021-12-25'),
(6003, NULL, NULL, 'PAID', '2021-12-25'),
(6011, 5007, NULL, 'Deleted', '2021-12-25'),
(0, 5007, NULL, 'On Process', '2021-12-25'),
(0, 5007, NULL, 'On Process', '2021-12-25'),
(0, 5006, NULL, 'On Process', '2021-12-25'),
(6014, 5006, NULL, 'Deleted', '2021-12-25'),
(6013, 5007, NULL, 'Deleted', '2021-12-25'),
(6012, 5007, NULL, 'Deleted', '2021-12-25'),
(6009, 5006, NULL, 'Deleted', '2021-12-25');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `ID_Invoice` int(11) NOT NULL,
  `ID_Pembeli` int(11) NOT NULL,
  `ID_Pesanan` int(11) NOT NULL,
  `Nama_Pembeli` varchar(50) NOT NULL,
  `Alamat_Pembeli` varchar(50) NOT NULL,
  `Nama_Produk` varchar(50) NOT NULL,
  `Jumlah_Produk` varchar(50) NOT NULL,
  `Total_Pembayaran` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`ID_Invoice`, `ID_Pembeli`, `ID_Pesanan`, `Nama_Pembeli`, `Alamat_Pembeli`, `Nama_Produk`, `Jumlah_Produk`, `Total_Pembayaran`) VALUES
(6001, 2001, 5001, 'Shofia', 'BOGOR', 'Seblak Instan', '10', '100000'),
(6002, 2002, 5002, 'Sakina', 'CIBINONG', 'Teobokki Instan', '2', '28000'),
(6003, 2003, 5003, 'Komarudin', 'CIKUNIR', 'CDR Vitamin C', '5', '100000'),
(6007, 2004, 5006, 'Reezq', 'Bandung', 'Madu Sumbawa', '3', '210000'),
(6008, 2003, 5007, 'Komar', 'Cikunir', 'OBH Herbal Anak', '2', '26000');

--
-- Triggers `invoice`
--
DELIMITER $$
CREATE TRIGGER `DeleteInvoice` BEFORE DELETE ON `invoice` FOR EACH ROW BEGIN
	INSERT INTO history_pesanan
    set No_Invoice = old.ID_Invoice,
    No_Pesanan = old.ID_Pesanan,
    Status_Pesanan = 'Deleted',
    Waktu = NOW();
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Log_Invoice` BEFORE INSERT ON `invoice` FOR EACH ROW BEGIN
	INSERT INTO history_pesanan
    set No_Invoice = new.ID_Invoice,
    No_Pesanan = new.ID_Pesanan,
    Status_Pesanan = 'On Process',
    Waktu = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `invoicepayment`
-- (See below for the actual view)
--
CREATE TABLE `invoicepayment` (
`ID_Invoice` int(11)
,`ID_Pembeli` int(11)
,`ID_Pesanan` int(11)
,`Nama_Produk` varchar(50)
,`Jumlah_Produk` varchar(50)
,`Total_Pembayaran` decimal(10,0)
,`Status_Pembayaran` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `keranjang`
--

CREATE TABLE `keranjang` (
  `ID_Keranjang` int(11) NOT NULL,
  `ID_Produk` int(11) NOT NULL,
  `Nama_Produk` varchar(50) NOT NULL,
  `Harga_Produk` decimal(10,0) NOT NULL,
  `Jumlah_Produk` int(11) NOT NULL,
  `Total_Pembayaran` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `keranjang`
--

INSERT INTO `keranjang` (`ID_Keranjang`, `ID_Produk`, `Nama_Produk`, `Harga_Produk`, `Jumlah_Produk`, `Total_Pembayaran`) VALUES
(4001, 3005, 'Seblak Instan', '10000', 10, '100000'),
(4002, 3007, 'Teobokki Instan', '14000', 2, '28000'),
(4003, 3001, 'CDR Vitamin C', '20000', 5, '100000'),
(4006, 3003, 'OBH Herbal Anak', '13000', 2, '26000'),
(4007, 3002, 'Madu Sumbawa', '70000', 3, '210000');

-- --------------------------------------------------------

--
-- Table structure for table `pembeli`
--

CREATE TABLE `pembeli` (
  `ID_Pembeli` int(11) NOT NULL,
  `Nama` varchar(50) NOT NULL,
  `Alamat_Email` varchar(50) NOT NULL,
  `No_Telp` varchar(12) NOT NULL,
  `Alamat` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembeli`
--

INSERT INTO `pembeli` (`ID_Pembeli`, `Nama`, `Alamat_Email`, `No_Telp`, `Alamat`) VALUES
(2001, 'Shofia', 'shofiajasmine@gmail.com', '081234567890', 'BOGOR'),
(2002, 'Sakina', 'sakinaradia@yahoo.com', '087812348765', 'CIBINONG'),
(2003, 'Komarudin', 'komarbulan@gmail.com', '085767895214', 'CIKUNIR'),
(2004, 'Reezq', 'reezq@gmail.com', '081378652345', 'BANDUNG');

-- --------------------------------------------------------

--
-- Table structure for table `penjual`
--

CREATE TABLE `penjual` (
  `ID_Penjual` int(11) NOT NULL,
  `Nama` varchar(50) NOT NULL,
  `Alamat_Email` varchar(50) NOT NULL,
  `No_Telp` varchar(25) DEFAULT NULL,
  `Alamat` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `penjual`
--

INSERT INTO `penjual` (`ID_Penjual`, `Nama`, `Alamat_Email`, `No_Telp`, `Alamat`) VALUES
(1001, 'Haris', 'haris007@gmail.com', '02134567212', 'Parung-Bogor'),
(1004, 'Aisyah', 'aisy@gmail.com', '02517634257', 'Pontianak'),
(1005, 'Zaid', 'zaidarkam@yahoo.com', '02519087324', 'Semarang'),
(1006, 'Ghina', 'ghinafitri@gmail.com', '02145679823', 'BOJONGSARI');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `ID_Pesanan` int(11) NOT NULL,
  `ID_Keranjang` int(11) NOT NULL,
  `Tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`ID_Pesanan`, `ID_Keranjang`, `Tanggal`) VALUES
(5001, 4001, '2021-12-24'),
(5002, 4002, '2021-12-24'),
(5003, 4003, '2021-12-24'),
(5006, 4006, '2021-12-25'),
(5007, 4007, '2021-12-25');

-- --------------------------------------------------------

--
-- Table structure for table `pilihan_produk`
--

CREATE TABLE `pilihan_produk` (
  `No_Produk` int(11) NOT NULL,
  `Nama_Produk` varchar(50) NOT NULL,
  `Nama_Penjual` varchar(50) NOT NULL,
  `Harga_Produk` decimal(10,0) NOT NULL,
  `Keterangan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pilihan_produk`
--

INSERT INTO `pilihan_produk` (`No_Produk`, `Nama_Produk`, `Nama_Penjual`, `Harga_Produk`, `Keterangan`) VALUES
(3001, 'CDR Vitamin C', 'Haris', '20000', 'Stok Tersedia'),
(3002, 'Madu Sumbawa', 'Haris', '70000', 'Stok Tersedia'),
(3003, 'OBH Herbal Anak', 'Haris', '13000', 'Stok Tersedia'),
(3005, 'Seblak Instan', 'Aisyah', '10000', 'Stok Tersedia'),
(3006, 'Baso Aci SEDAP', 'Aisyah', '7000', 'Stok Tersedia'),
(3007, 'Teobokki Instan', 'Aisyah', '14000', 'Stok Tersedia'),
(3008, 'Byclin Pemutih 250ml', 'Zaid', '10000', 'Stok Tersedia'),
(3009, 'Lifebuoy Handsanitizer 500ml', 'Zaid', '15000', 'Stok Tersedia'),
(3010, 'Dee Dee Sabun Cuci Tangan 500ml', 'Zaid', '10000', 'Stok Tersedia');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `ID_Produk` int(11) NOT NULL,
  `ID_Penjual` int(11) NOT NULL,
  `Nama_Produk` varchar(50) NOT NULL,
  `Jumlah_Produk` tinyint(4) NOT NULL,
  `Harga_Produk` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`ID_Produk`, `ID_Penjual`, `Nama_Produk`, `Jumlah_Produk`, `Harga_Produk`) VALUES
(3001, 1001, 'CDR Vitamin C', 20, '20000'),
(3002, 1001, 'Madu Sumbawa', 30, '70000'),
(3003, 1001, 'OBH Herbal Anak', 15, '13000'),
(3005, 1004, 'Seblak Instan', 50, '10000'),
(3006, 1004, 'Baso Aci SEDAP', 50, '7000'),
(3007, 1004, 'Teobokki Instan', 25, '14000'),
(3008, 1005, 'Byclin Pemutih 250ml', 20, '10000'),
(3009, 1005, 'Lifebuoy Handsanitizer 50ml', 40, '15000'),
(3010, 1005, 'Dee Dee Sabun Cuci Tangan 500ml', 50, '15000');

-- --------------------------------------------------------

--
-- Table structure for table `struk`
--

CREATE TABLE `struk` (
  `ID_Struk` int(11) NOT NULL,
  `ID_Invoice` int(11) NOT NULL,
  `Total_Pembayaran` decimal(10,0) NOT NULL,
  `Metode_Pembayaran` varchar(50) NOT NULL,
  `Tanggal_Pembayaran` date NOT NULL,
  `Status_Pembayaran` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `struk`
--

INSERT INTO `struk` (`ID_Struk`, `ID_Invoice`, `Total_Pembayaran`, `Metode_Pembayaran`, `Tanggal_Pembayaran`, `Status_Pembayaran`) VALUES
(7001, 6001, '100000', 'Bank Transfer', '0000-00-00', 'PAID'),
(7002, 6002, '28000', 'Bank Transfer', '2021-12-24', 'PAID'),
(7003, 6003, '100000', 'Bank Transfer', '0000-00-00', 'PAID');

--
-- Triggers `struk`
--
DELIMITER $$
CREATE TRIGGER `Log_Struk` BEFORE UPDATE ON `struk` FOR EACH ROW BEGIN
	INSERT INTO history_pesanan
    set No_Invoice = new.ID_Invoice,
    Status_Pesanan = new.Status_Pembayaran,
    Waktu = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `invoicepayment`
--
DROP TABLE IF EXISTS `invoicepayment`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `invoicepayment`  AS SELECT `invoice`.`ID_Invoice` AS `ID_Invoice`, `invoice`.`ID_Pembeli` AS `ID_Pembeli`, `invoice`.`ID_Pesanan` AS `ID_Pesanan`, `invoice`.`Nama_Produk` AS `Nama_Produk`, `invoice`.`Jumlah_Produk` AS `Jumlah_Produk`, `invoice`.`Total_Pembayaran` AS `Total_Pembayaran`, `struk`.`Status_Pembayaran` AS `Status_Pembayaran` FROM (`invoice` join `struk` on(`invoice`.`ID_Invoice` = `struk`.`ID_Invoice`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `history_pesanan`
--
ALTER TABLE `history_pesanan`
  ADD KEY `No_Invoice` (`No_Invoice`),
  ADD KEY `No_Pesanan` (`No_Pesanan`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`ID_Invoice`),
  ADD KEY `ID_Pembeli` (`ID_Pembeli`),
  ADD KEY `ID_Pesanan` (`ID_Pesanan`);

--
-- Indexes for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD PRIMARY KEY (`ID_Keranjang`),
  ADD KEY `ID_Produk` (`ID_Produk`);

--
-- Indexes for table `pembeli`
--
ALTER TABLE `pembeli`
  ADD PRIMARY KEY (`ID_Pembeli`);

--
-- Indexes for table `penjual`
--
ALTER TABLE `penjual`
  ADD PRIMARY KEY (`ID_Penjual`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`ID_Pesanan`),
  ADD KEY `ID_Keranjang` (`ID_Keranjang`);

--
-- Indexes for table `pilihan_produk`
--
ALTER TABLE `pilihan_produk`
  ADD KEY `No_Produk` (`No_Produk`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`ID_Produk`),
  ADD KEY `ID_Penjual` (`ID_Penjual`);

--
-- Indexes for table `struk`
--
ALTER TABLE `struk`
  ADD PRIMARY KEY (`ID_Struk`),
  ADD KEY `ID_Invoice` (`ID_Invoice`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `ID_Invoice` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6015;

--
-- AUTO_INCREMENT for table `keranjang`
--
ALTER TABLE `keranjang`
  MODIFY `ID_Keranjang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4008;

--
-- AUTO_INCREMENT for table `pembeli`
--
ALTER TABLE `pembeli`
  MODIFY `ID_Pembeli` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2005;

--
-- AUTO_INCREMENT for table `penjual`
--
ALTER TABLE `penjual`
  MODIFY `ID_Penjual` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1007;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `ID_Pesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5008;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `ID_Produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3011;

--
-- AUTO_INCREMENT for table `struk`
--
ALTER TABLE `struk`
  MODIFY `ID_Struk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7004;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `history_pesanan`
--
ALTER TABLE `history_pesanan`
  ADD CONSTRAINT `No_Pesanan` FOREIGN KEY (`No_Pesanan`) REFERENCES `pesanan` (`ID_Pesanan`);

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `ID_Pembeli` FOREIGN KEY (`ID_Pembeli`) REFERENCES `pembeli` (`ID_Pembeli`),
  ADD CONSTRAINT `ID_Pesanan` FOREIGN KEY (`ID_Pesanan`) REFERENCES `pesanan` (`ID_Pesanan`);

--
-- Constraints for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD CONSTRAINT `ID_Produk` FOREIGN KEY (`ID_Produk`) REFERENCES `produk` (`ID_Produk`);

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`ID_Keranjang`) REFERENCES `keranjang` (`ID_Keranjang`);

--
-- Constraints for table `pilihan_produk`
--
ALTER TABLE `pilihan_produk`
  ADD CONSTRAINT `No_Produk` FOREIGN KEY (`No_Produk`) REFERENCES `produk` (`ID_Produk`);

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `ID_Penjual` FOREIGN KEY (`ID_Penjual`) REFERENCES `penjual` (`ID_Penjual`);

--
-- Constraints for table `struk`
--
ALTER TABLE `struk`
  ADD CONSTRAINT `ID_Invoice` FOREIGN KEY (`ID_Invoice`) REFERENCES `invoice` (`ID_Invoice`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
