part of 'x_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<LoginBloc>(context).add(LoadUserDateEvent());
    BlocProvider.of<ProductBloc>(context).add(FetchListCategoryEvent());
    BlocProvider.of<ProductBloc>(context).add(FetchListProductEvent());
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (isTop) {
          BlocProvider.of<ProductBloc>(context).add(ShowSeeMore(false));
        } else {
          BlocProvider.of<ProductBloc>(context).add(ShowSeeMore(true));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorName.deepGrey,
                ),
              );
            } else if (state.status.isSuccess) {
              if (state.listProductModel != null) {
                if (state.listProductModel!.isNotEmpty) {
                  return Column(
                    children: [
                      _buildAppBar(context),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/20,
                        child: _buildTabCategory(context, state),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      _buildGridProduct(state),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                return const SizedBox();
              }
            } else if (state.status.isError) {
              return Center(
                child: Text(state.message ?? 'Terjadi Kesalahan'),
              );
            }
            return const SizedBox();
          },
        ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorName.deepGrey,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 6, left: 18, right: 8),
        child: Row(
          children: [
            const Expanded(
                child: Text(
              'Home',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return const SizedBox();
                  }
                  else if (state.status.isSuccess) {
                    if (state.username != null) {
                      return Row(
                        children: [
                          Text('${state.username}',
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            height: 65,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: Image.network(
                                '${state.image}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          MaterialButton(
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)
                            ),
                            color: Colors.white,
                            onPressed: () {
                              context.go(pageName.login);
                            },
                            child: const Text('LOG IN'),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            height: 65,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: Image.asset(
                                'assets/icons/user.png',
                                fit: BoxFit.cover,
                                // color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  } else if (state.status.isError) {
                    return const SizedBox(
                      height: 70,
                    );
                  }
                  return const SizedBox(
                    height: 70,
                  );
                }
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabCategory(BuildContext context,ProductState state) {
    return state.listCategory != null ? ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: state.listCategory!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: GestureDetector(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: ColorName.deepGrey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Text(state.listCategory![index], style: const TextStyle(color: Colors.white, fontSize: 16)),
                      )
                    ),
                  )
              ),
              onTap: () {
                BlocProvider.of<ProductBloc>(context).add(FetchListProductEvent(nameCategory: '/category/${state.listCategory![index]}/'));
              },
            ),
          );
        },
    ) : const SizedBox();
  }

  Widget _buildGridProduct(ProductState state) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4, left: 12, right: 12),
          child: Stack(
        children: [
        GridView.builder(
        controller: _scrollController,
          // padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
          ),
          itemCount: state.listProductModel!.length,
          itemBuilder: (context, index) {
            return GridProductWidget(
                pictures: state.listProductModel![index].thumbnail ?? '',
                name: state.listProductModel![index].title ?? '',
                price: state.listProductModel![index].price ?? 0,
                id: state.listProductModel![index].id!,
            );
          },
        ),
        state.seeMore != null ? state.seeMore!
            ?
        Align(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
                onPressed: (){
                  BlocProvider.of<ProductBloc>(context).add(FetchListProductByPageEvent(skip: state.listProductModel!.length, nameCategory: state.category ?? ''));
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black54
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(height: 15,),
                      Text('See more', style: TextStyle(color: Colors.white),),
                      SizedBox(width: 15,),
                      Icon(Icons.arrow_downward_rounded, color: Colors.white,),
                      SizedBox(height: 15,),
                    ],
                  ),
                )
            )
        )
            : const SizedBox()
            : const SizedBox(),
        ]
        ),
        ),
    );
  }
}
