class Slide {
  String title;
  String description;
  String imagePath;
  Slide({this.title, this.description, this.imagePath});

  static List<Slide> slides = [
    Slide(
        title: 'Creating An Account.',
        description: '',
        imagePath: 'assets/images/Form.svg'),
    Slide(
        title: 'Get Your Account Approve',
        description:
            'Once you submit details get your account approved with 48 hours. ',
        imagePath: 'assets/images/Approval.svg'),
    Slide(
        title: 'Heading: Choose Consignment & Bid.',
        description: 'Select a consignment and enter your lowest rate.',
        imagePath: 'assets/images/Auction.svg'),
    Slide(
        title: 'Lowest Bid Wins',
        description:
            'Bring your vehicle to the Pickup location. This is that simple.',
        imagePath: 'assets/images/Truck.svg')
  ];
  static List<Slide> slidesInHindi = [
    Slide(
        title: 'अपना अकाउंट बनाये',
        description: '',
        imagePath: 'assets/images/Form.svg'),
    Slide(
      title: 'अपने अकाउंट को मंजूर करवाए',
      description: '',
      imagePath: 'assets/images/Approval.svg',
    ),
    Slide(
        title: 'कन्साइनमेंट देख कर अपने रेट डाले',
        description: '',
        imagePath: 'assets/images/Auction.svg'),
    Slide(
        title: 'अपना ट्रक लाये',
        description: 'समय पर अपना ट्रक लाये और लोड कर वाये',
        imagePath: 'assets/images/Truck.svg')
  ];
}
