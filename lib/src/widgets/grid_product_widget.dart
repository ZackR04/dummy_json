part of 'x_widgets.dart';

class GridProductWidget extends StatelessWidget {
  final String? pictures;
  final String? name;
  final int? price;
  final int? id;

  const GridProductWidget({
    super.key,
    required this.pictures,
    required this.name,
    required this.price,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.grey.withOpacity(0.2),
      ),
      ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: SizedBox(
                height: MediaQuery.of(context).size.height/7.5,
                child: Image.network('$pictures', fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(child: Text('$name', textAlign: TextAlign.center,)),
            const SizedBox(
              height: 4,
            ),
            Text('\$$price', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
      onTap: () => context.go(pageName.detailPath, extra: id),
    );
  }
}
