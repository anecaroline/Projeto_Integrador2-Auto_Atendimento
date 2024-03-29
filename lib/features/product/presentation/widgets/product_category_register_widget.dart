import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_category_register_controller.dart';

class ProductCategoryRegisterWidget extends StatelessWidget {
  ProductCategoryRegisterWidget({super.key});

  final _controller = Get.find<ProductCategoryRegisterController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    late String name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 15),
        SizedBox(
          width: 500,
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Cadastro das Categorias',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => _controller.isLoading.value
                        ? const Center(
                            child: SizedBox(
                                height: 40, child: CircularProgressIndicator()))
                        : _controller.imageFileSelected == null
                            ? Image.asset(
                                'assets/images/no-img.jpg',
                                height: 180.0,
                                width: 250,
                              )
                            : Image.memory(_controller.imageFileSelected!,
                                height: 250),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _controller.getLocalImage,
                    child: const Text('Adicionar Imagem'),
                  ),
                  const SizedBox(height: 35),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      strutStyle:
                          const StrutStyle(height: 1.6, forceStrutHeight: true),
                      decoration: const InputDecoration(
                        labelText: 'Nome da Categoria',
                      ),
                      onSaved: (value) => name = value!,
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: Get.back,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              await _controller.insertProductCategory(name);
                            }
                          },
                          child: const Text('Cadastrar')),
                    ],
                  ),
                ],
              )),
            ),
          ),
        ),
      ],
    );
  }
}
