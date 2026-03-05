class Book {
  String name;
  String image;
  String description;
  double rate;
  int page;
  String categoryBook;
  String language;

  Book({
    required this.name,
    required this.image,
    required this.description,
    required this.rate,
    required this.page,
    required this.categoryBook,
    required this.language,
  });
}

List<Book> listBook = [
  Book(
    name: 'Redhat',
    image: 'images/buku-redhat.png',
    description: '''Red Hat adalah salah satu perusahaan terbesar dan dikenal 
untuk dedikasinya atas perangkat lunak sumber terbuka. Red Hat didirikan pada 
1993 dan bermarkas di Raleigh, North Carolina, Amerika Serikat. 
Red Hat terkenal karena produknya Red Hat Linux, salah satu distro Linux utama.''',
    rate: 4.3,
    page: 229,
    categoryBook: 'Sysadmin IDN',
    language: 'IDN',
  ),
  Book(
    name: 'Docker',
    image: 'images/buku-docker.png',
    description: '''Docker adalah sekumpulan platform sebagai produk layanan 
yang menggunakan virtualisasi tingkat OS untuk mengirimkan perangkat lunak 
dalam paket yang disebut container.''',
    rate: 4.2,
    page: 210,
    categoryBook: 'Sysadmin IDN',
    language: 'IDN',
  ),
  Book(
    name: 'Hyper-V',
    image: 'images/buku-hyper-v.png',
    description: '''Hyper-V adalah teknologi virtualisasi dari Microsoft yang 
memungkinkan pembuatan dan pengelolaan mesin virtual pada sistem operasi Windows.''',
    rate: 4.2,
    page: 210,
    categoryBook: 'Sysadmin IDN',
    language: 'IDN',
  ),
  Book(
    name: 'NMS',
    image: 'images/buku-nms.png',
    description: '''Network Monitoring System (NMS) merupakan tool untuk 
melakukan monitoring atau pengawasan pada elemen-elemen dalam jaringan komputer. 
Fungsi utamanya adalah memantau kualitas SLA (Service Level Agreement) dari bandwidth.''',
    rate: 4.4,
    page: 210,
    categoryBook: 'Sysadmin IDN',
    language: 'IDN',
  ),
  Book(
    name: 'VPN',
    image: 'images/buku-vpn.png',
    description: '''Virtual Private Network (VPN) adalah jaringan pribadi 
maya yang memperluas jaringan privat melalui jaringan publik, sehingga 
pengguna dapat mengirim dan menerima data dengan aman.''',
    rate: 4.4,
    page: 210,
    categoryBook: 'Network IDN',
    language: 'IDN',
  ),
  Book(
    name: 'Openstack',
    image: 'images/buku-openstack-admin.png',
    description: '''OpenStack adalah platform cloud computing open-source 
yang digunakan sebagai Infrastructure as a Service (IaaS), 
di mana server virtual dan sumber daya lain tersedia bagi pengguna.''',
    rate: 4.5,
    page: 210,
    categoryBook: 'Network IDN',
    language: 'IDN',
  ),
];

