part of floating_expandable_menu;

class CustomExpandableMenuButton extends StatefulWidget {
  final double? minHeight;
  final double? expandedHeight;

  final TextStyle? textStyle;

  final double widthWhenNotExpanded;
  final ScrollController controller;
  final Color? backgroundColor;
  final TextStyle? menuTextStyle;
  final String? title;
  final Widget? separator;
  final List<CustomExpandableMenuButtonDataModel> itemsList;
  // List<int> countList;
  final Function onTapItem;
  final Function onTap;
  final List<GlobalKey>? keyList;
  CustomExpandableMenuButton(
      {super.key,
      this.title,
      this.expandedHeight,
      this.separator,
      this.menuTextStyle,
      required this.textStyle,
      required this.widthWhenNotExpanded,
      required this.controller,
      required this.onTapItem,
      this.backgroundColor,
      required this.itemsList,
      this.minHeight,
      this.keyList,
      required this.onTap});

  @override
  State<CustomExpandableMenuButton> createState() =>
      _CustomExpandableMenuButtonState();
}

class _CustomExpandableMenuButtonState
    extends State<CustomExpandableMenuButton> {
  bool isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  handleExpandEvents() {
    widget.onTap(isExpanded);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        isExpanded
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  handleExpandEvents();
                },
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                ),
              )
            : SizedBox(),
        GestureDetector(
          onTap: () {
            handleExpandEvents();
          },
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 300),
            height: isExpanded
                ? /*foodController.arrCuisineList.length > 4
                                ? ScreenConstant.size300
                                : minHeight +ScreenConstant.size50*/

                widget.expandedHeight ?? 300
                : widget.minHeight ?? 45,
            width: isExpanded
                ? MediaQuery.of(context).size.width * 0.8
                : widget.widthWhenNotExpanded,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.backgroundColor ?? Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.menu,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.title ?? 'Menu',
                      style: widget.textStyle ??
                          const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                // ...widget.itemsList,
                Expanded(
                  child: ListView.separated(
                    controller: widget.controller,
                    padding: EdgeInsets.only(top: 0),
                    itemCount: widget.itemsList.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return widget.separator ??
                          const SizedBox(
                            height: 2.0,
                          );
                    },
                    itemBuilder: (context, indexI) {
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          isExpanded = !isExpanded;

                          widget.onTapItem(indexI);

                          setState(() {});
                        },
                        child: widget.itemsList != 0
                            ? Padding(
                                key: widget.keyList?[indexI] ?? null,
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${widget.itemsList[indexI].title}",
                                        style: widget.menuTextStyle ??
                                            const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white),
                                      ),
                                      Text(
                                        "${widget.itemsList[indexI].numberOfItems}",
                                        style: widget.menuTextStyle ??
                                            const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
