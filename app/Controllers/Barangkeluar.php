<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\ModelBarangKeluar;

class Barangkeluar extends BaseController
{
    private function buatFaktur()
    {
        $tanggalSekarang = date('Y-m-d');
        $modelBarangKeluar = new ModelBarangKeluar();

        $hasil = $modelBarangKeluar->noFaktur($tanggalSekarang)->getRowArray();
        $data = $hasil['nofaktur'];

        $lastNoUrut = substr($data, -4);
        $nextNoUrut = intval($lastNoUrut) + 1;
        $noFaktur = date('dmy', strtotime($tanggalSekarang)) . sprintf('%04s', $nextNoUrut);
        return $noFaktur;
    }
    public function buatNoFaktur(){
        $tanggalSekarang = $this->request->getPost('tanggal');
        $modelBarangKeluar = new ModelBarangKeluar();

        $hasil = $modelBarangKeluar->noFaktur($tanggalSekarang)->getRowArray();
        $data = $hasil['nofaktur'];

        $lastNoUrut = substr($data, -4);
        $nextNoUrut = intval($lastNoUrut) + 1;
        $noFaktur = date('dmy', strtotime($tanggalSekarang)) . sprintf('%04s', $nextNoUrut);
        
        $json = [
            'nofaktur' => $noFaktur
        ];
        echo json_encode($json);

    }
    public function data()
    {
        return view('barangkeluar/viewdata');
    }

    public function input()
    {
        $data = [
            'nofaktur' => $this->buatFaktur()
        ];
        return view('barangkeluar/forminput', $data);
    }
}
