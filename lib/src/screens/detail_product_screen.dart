part of 'x_screens.dart';

class DetailProductScreen extends StatefulWidget {
  final int id;

  const DetailProductScreen({
    super.key, required this.id,
  });

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {

  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context)
        .add(FetchDetailProductEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorName.deepGrey,
          title: const Text('Back'),
        ),
        body: SafeArea(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorName.deepGrey,
                  ),
                );
              } else if (state.status.isSuccess) {
                if (state.detailProductModel != null) {
                  return Column(
                    children: [
                      Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              _buildListImage(state, context),
                              const SizedBox(
                                height: 20,
                              ),
                              _buildDetailProduct(state),
                            ],
                          ),
                      ),
                      _buildButtonCart(state),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('Produk Kosong'),
                  );
                }
              } else if (state.status.isError) {
                return Center(
                  child: Text(state.message ?? 'Terjadi Kesalahan'),
                );
              }
              return const SizedBox();
            },
          )
       ),
    );
  }

  Widget _buildListImage(ProductState state, BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          enableInfiniteScroll: false,
          viewportFraction: 1,
          initialPage: 0,
          scrollDirection: Axis.horizontal,
      ),
      items: state.detailProductModel!.images?.map((item) {
        return SizedBox(
          height: MediaQuery.of(context).size.height/3.5,
          child: Image.network(
            item,
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDetailProduct(ProductState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              children: [
                Expanded(
                  child: Text('${state.detailProductModel!.title}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                const Text(
                  // '${state.detailProductModel!.discountPercentage}'
                    '27.54% off', style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold)),
              ]
          ),
          const SizedBox(
            height: 10,
          ),
          Text('${state.detailProductModel!.description}', style: const TextStyle(fontSize: 16),),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset('assets/icons/tag.png',
                scale: 16,),
              const SizedBox(
                width: 10,),
              Text('${state.detailProductModel!.brand}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset('assets/icons/ready-stock.png',
                scale: 16,),
              const SizedBox(
                width: 10,),
              Text(
                '${state.detailProductModel!.stock}'
                    ' stocks', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ],
          ),
          // Text('${state.detailProductModel!.rating}')
        ],
      ),
    );
  }

  Widget _buildButtonCart(ProductState state) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
          top: BorderSide(
            color: ColorName.deepGrey,
            width: 0.2
          ),
        )
      ),
      height: MediaQuery.of(context).size.height/12,
      child: Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text('\$${state.detailProductModel!.price}', style: const TextStyle(fontSize: 32),),
                ),
            ),
            MaterialButton(
              height: MediaQuery.of(context).size.height,
              color: ColorName.deepGrey,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30))),
              onPressed: (){},
              child: Row(
                children: const [
                  Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 16),),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.add_shopping_cart, color: Colors.white,),
                ],
              )
            ),
          ],
        ),
    );
  }
}
