-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Sep 2023 pada 12.29
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbhks`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `brgkode` char(10) NOT NULL,
  `brgnama` varchar(100) NOT NULL,
  `brgkatid` int(10) UNSIGNED NOT NULL,
  `brgsatid` int(10) UNSIGNED NOT NULL,
  `brgharga` double NOT NULL,
  `brggambar` varchar(200) DEFAULT NULL,
  `brgstok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`brgkode`, `brgnama`, `brgkatid`, `brgsatid`, `brgharga`, `brggambar`, `brgstok`) VALUES
('A00002', 'Oskadon', 32, 11, 2500, 'upload/A00002_2.png', 160),
('A00003', 'Flucadex', 32, 10, 20000, 'upload/A00003.png', 75),
('A00004', 'Acifar', 32, 10, 20000, 'upload/A00004.png', 30),
('A00009', 'Momilen', 32, 10, 20000, 'upload/A00009.png', 15);

-- --------------------------------------------------------

--
-- Struktur dari tabel `barangkeluar`
--

CREATE TABLE `barangkeluar` (
  `faktur` char(20) NOT NULL,
  `tglfaktur` date DEFAULT NULL,
  `idpel` int(11) DEFAULT NULL,
  `totalharga` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barangmasuk`
--

CREATE TABLE `barangmasuk` (
  `faktur` char(20) NOT NULL,
  `tglfaktur` date NOT NULL,
  `totalharga` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_barangkeluar`
--

CREATE TABLE `detail_barangkeluar` (
  `id` bigint(20) NOT NULL,
  `detfaktur` char(20) DEFAULT NULL,
  `detbrgkode` char(10) DEFAULT NULL,
  `dethargajual` double DEFAULT NULL,
  `detjml` int(11) DEFAULT NULL,
  `detsubtotal` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_barangmasuk`
--

CREATE TABLE `detail_barangmasuk` (
  `iddetail` bigint(20) NOT NULL,
  `detfaktur` char(20) NOT NULL,
  `detbrgkode` char(10) NOT NULL,
  `dethargamasuk` double NOT NULL,
  `dethargajual` double NOT NULL,
  `detjml` int(11) NOT NULL,
  `detsubtotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Trigger `detail_barangmasuk`
--
DELIMITER $$
CREATE TRIGGER `tri_tambah_stok_barang` AFTER INSERT ON `detail_barangmasuk` FOR EACH ROW BEGIN
      UPDATE
	barang
      SET
	barang.`brgstok` = barang.`brgstok` + new.detjml WHERE barang.`brgkode`=new.detbrgkode;
    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `triger_kurangistok` AFTER DELETE ON `detail_barangmasuk` FOR EACH ROW BEGIN
	UPDATE barang SET brgstok = brgstok - old.detjml where brgkode = old.detbrgkode;
    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `triget_updatestok` AFTER UPDATE ON `detail_barangmasuk` FOR EACH ROW BEGIN
	update barang set brgstok = (brgstok - old.detjml) + new.detjml
	where brgkode = new.detbrgkode;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `katid` int(10) UNSIGNED NOT NULL,
  `katnama` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`katid`, `katnama`) VALUES
(31, 'Obat Sirup'),
(32, 'Obat Tablet'),
(33, 'Obat Keras'),
(34, 'dus');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `version`, `class`, `group`, `namespace`, `time`, `batch`) VALUES
(1, '2023-08-20-120129', 'App\\Database\\Migrations\\Kategori', 'default', 'App', 1692533299, 1),
(2, '2023-08-20-120134', 'App\\Database\\Migrations\\Satuan', 'default', 'App', 1692533299, 1),
(3, '2023-08-20-120139', 'App\\Database\\Migrations\\Barang', 'default', 'App', 1692533299, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `pelid` int(11) NOT NULL,
  `pelnama` varchar(100) DEFAULT NULL,
  `peltelp` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `satuan`
--

CREATE TABLE `satuan` (
  `satid` int(10) UNSIGNED NOT NULL,
  `satnama` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data untuk tabel `satuan`
--

INSERT INTO `satuan` (`satid`, `satnama`) VALUES
(10, 'Box'),
(11, 'Sachet'),
(12, 'pcs'),
(13, 'botol');

-- --------------------------------------------------------

--
-- Struktur dari tabel `temp_barangkeluar`
--

CREATE TABLE `temp_barangkeluar` (
  `id` bigint(20) NOT NULL,
  `detfaktur` char(20) DEFAULT NULL,
  `detbrgkode` char(10) DEFAULT NULL,
  `dethargajual` double DEFAULT NULL,
  `detjml` int(11) DEFAULT NULL,
  `detsubtotal` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `temp_barangmasuk`
--

CREATE TABLE `temp_barangmasuk` (
  `iddetail` bigint(20) NOT NULL,
  `detfaktur` char(20) NOT NULL,
  `detbrgkode` char(10) NOT NULL,
  `dethargamasuk` double NOT NULL,
  `dethargajual` double NOT NULL,
  `detjml` int(11) NOT NULL,
  `detsubtotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`brgkode`),
  ADD KEY `barang_brgkatid_foreign` (`brgkatid`),
  ADD KEY `barang_brgsatid_foreign` (`brgsatid`);

--
-- Indeks untuk tabel `barangkeluar`
--
ALTER TABLE `barangkeluar`
  ADD PRIMARY KEY (`faktur`);

--
-- Indeks untuk tabel `barangmasuk`
--
ALTER TABLE `barangmasuk`
  ADD PRIMARY KEY (`faktur`);

--
-- Indeks untuk tabel `detail_barangkeluar`
--
ALTER TABLE `detail_barangkeluar`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `detail_barangmasuk`
--
ALTER TABLE `detail_barangmasuk`
  ADD PRIMARY KEY (`iddetail`),
  ADD KEY `detbrgkode` (`detbrgkode`),
  ADD KEY `detfaktur` (`detfaktur`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD KEY `katid` (`katid`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`pelid`);

--
-- Indeks untuk tabel `satuan`
--
ALTER TABLE `satuan`
  ADD KEY `satid` (`satid`);

--
-- Indeks untuk tabel `temp_barangkeluar`
--
ALTER TABLE `temp_barangkeluar`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `temp_barangmasuk`
--
ALTER TABLE `temp_barangmasuk`
  ADD PRIMARY KEY (`iddetail`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `detail_barangkeluar`
--
ALTER TABLE `detail_barangkeluar`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `detail_barangmasuk`
--
ALTER TABLE `detail_barangmasuk`
  MODIFY `iddetail` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `katid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `pelid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `satuan`
--
ALTER TABLE `satuan`
  MODIFY `satid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `temp_barangkeluar`
--
ALTER TABLE `temp_barangkeluar`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `temp_barangmasuk`
--
ALTER TABLE `temp_barangmasuk`
  MODIFY `iddetail` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_brgkatid_foreign` FOREIGN KEY (`brgkatid`) REFERENCES `kategori` (`katid`),
  ADD CONSTRAINT `barang_brgsatid_foreign` FOREIGN KEY (`brgsatid`) REFERENCES `satuan` (`satid`);

--
-- Ketidakleluasaan untuk tabel `detail_barangmasuk`
--
ALTER TABLE `detail_barangmasuk`
  ADD CONSTRAINT `detail_barangmasuk_ibfk_1` FOREIGN KEY (`detbrgkode`) REFERENCES `barang` (`brgkode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `detail_barangmasuk_ibfk_2` FOREIGN KEY (`detfaktur`) REFERENCES `barangmasuk` (`faktur`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
