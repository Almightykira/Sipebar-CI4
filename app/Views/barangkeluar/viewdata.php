<?= $this->extend('main/layout') ?>

<?= $this->section('judul') ?>
Data Transaksi Barang Keluar
<?= $this->endSection('judul') ?>

<?= $this->section('subjudul') ?>

<button type="button" class="btn btn-sm btn-primary" onclick="location.href=('/barangkeluar/input')">
    <i class="fa fa-plus-circle"></i> Input Transaksi </button>
<?= $this->endSection('subjudul') ?>


<?= $this->section('isi') ?>

<div class="row">
    <div class="col-lg-4">
        <label for="">No.Faktur</label>
        <input type="text" name="nofaktur" id="nofaktur" class="form-control" readonly>
    </div>

    <div class="col-lg-4">
        <label for="">Tgl.Faktur</label>
        <input type="text" name="tglfaktur" id="tglfaktur" class="form-control" value="<?= date('Y-m-d') ?>">
    </div>

    <div class="col-lg-4">
        <label for="">Cari Pelanggan Apotek</label>
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Nama Apotek" name="namaapotek" id="namaapotek"
                readonly>
            <input type="hidden" name="idapotek" id="idapotek">
            <div class="input-group-append">
                <button class="btn btn-outline-primary" type="button" id="tombolCariApotek" title="Cari Apotek">
                    <i class="fa fa-search"></i>
                </button>
                <button class="btn btn-outline-success" type="button" id="tombolTambahApotek" title="Tambah Apotek">
                    <i class="fa fa-plus-square"></i>
                </button>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-2">
        <div class="form-group">
            <label for="">Kode Barang</label>
            <div class="input-group mb-3">
                <input type="text" class="form-control" placeholder="kodebarang" id="kodebarang">
                <div class="input-group-append">
                    <button class="btn btn-outline-primary" type="button" id="tombolCariBarang">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-3">
        <div class="form-group">
            <label for="">Nama Obat</label>
            <input type="text" name="namabarang" id="namabarang" class="form-control" readonly>
        </div>
    </div>
    
    <div class="col-lg-3">
        <div class="form-group">
            <label for="">Harga Jual (Rp)</label>
            <input type="text" name="hargajual" id="hargajual" class="form-control" readonly>
        </div>
    </div>
    
    <div class="col-lg-2">
        <div class="form-group">
            <label for="">qty</label>
            <input type="number" name="jumlah" id="jumlah" class="form-control" value="1">
        </div>
    </div>
    <div class="col-lg-2">
        <div class="form-group">
            <label for="">#</label>
            <div class="input-group mb-3">
                <button type="button" class="btn btn-success" title="Simpan Item" id="tombolSimpanItem">
                    <i class="fa fa-save"></i>
                </button>
            </div>
        </div>
    </div>
</div>
<?= $this->endSection('isi') ?>