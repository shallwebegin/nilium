import 'package:flutter/material.dart';
import 'package:nilium/feature/home_create/home_logic.dart';
import 'package:nilium/product/constants/color_constants.dart';
import 'package:nilium/product/constants/enums/widget_size.dart';
import 'package:nilium/product/constants/string_constants.dart';
import 'package:nilium/product/models/category.dart';

class HomeCreateView extends StatefulWidget {
  const HomeCreateView({super.key});

  @override
  State<HomeCreateView> createState() => _HomeCreateViewState();
}

class _HomeCreateViewState extends State<HomeCreateView> with Loading {
  late final HomeLogic _homeLogic;

  @override
  void initState() {
    super.initState();
    _homeLogic = HomeLogic();
    _fetchInitialCategory();
  }

  Future<void> _fetchInitialCategory() async {
    await _homeLogic.fetchAllCategory();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (isLoading)
            const Center(
                child: CircularProgressIndicator(
              color: ColorConstants.white,
            ))
        ],
        backgroundColor: ColorConstants.purplePrimary,
        title: const Text(StringConstants.homeCreateViewAppBarTitle),
      ),
      body: Form(
        key: _homeLogic.formKey,
        onChanged: () {
          _homeLogic.checkValidateAndSave(
            (value) {
              setState(() {});
            },
          );
        },
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              _HomeCategoryDropdown(
                categories: _homeLogic.categories,
                onSelected: _homeLogic.updateCategory,
              ),
              const _EmptySizedBox(),
              TextFormField(
                controller: _homeLogic.titleController,
                validator: (value) => value == null ? 'Not Empty' : null,
                decoration: const InputDecoration(
                  hintText: StringConstants.homeCreateViewAppBarTitle,
                  border: OutlineInputBorder(),
                ),
              ),
              const _EmptySizedBox(),
              InkWell(
                onTap: () async {
                  await _homeLogic.pickAndCheck(
                    (value) {
                      setState(() {});
                    },
                  );
                },
                child: SizedBox(
                  height: 200,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstants.grayPrimary),
                    ),
                    child: _homeLogic.selectedFileBytes != null
                        ? Image.memory(_homeLogic.selectedFileBytes!)
                        : const Icon(Icons.add_a_photo_outlined),
                  ),
                ),
              ),
              const _EmptySizedBox(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(
                    WidgetSize.buttonNormal.value.toDouble(),
                  ),
                ),
                onPressed: !_homeLogic.isValidateAllForm
                    ? null
                    : () async {
                        changeLoading();
                        await _homeLogic.save();
                        changeLoading();
                      },
                icon: const Icon(Icons.send),
                label: const Text(StringConstants.buttonSave),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySizedBox extends StatelessWidget {
  const _EmptySizedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}

class _HomeCategoryDropdown extends StatelessWidget {
  const _HomeCategoryDropdown(
      {required this.categories, required this.onSelected, super.key});

  final List<CategoryModel> categories;
  final ValueSetter<CategoryModel> onSelected;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CategoryModel>(
      validator: (value) => value == null ? 'Not Empty' : null,
      items: categories.map((e) {
        return DropdownMenuItem<CategoryModel>(
          value: e,
          child: Text(e.name ?? ''),
        );
      }).toList(),
      hint: const Text(StringConstants.dropdownHint),
      onChanged: (value) {
        if (value == null) return;

        onSelected.call(value);
      },
    );
  }
}

mixin Loading on State<HomeCreateView> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
