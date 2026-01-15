import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/name_controller.dart';

class GetXPage extends StatelessWidget {
  const GetXPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NameController controller = Get.put(NameController());
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Binding (GetX)"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: "Masukkan nama...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Tambah"),
                  onPressed: () {
                    controller.addName(textController.text);
                    textController.clear();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.names.isEmpty) {
                  return const Center(
                    child: Text(
                      "Belum ada data",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: controller.names.length,
                  itemBuilder: (context, index) {
                    final name = controller.names[index];
                    return ListTile(
                      title: Text(name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => controller.deleteName(index),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        if (controller.names.isEmpty) return const SizedBox();
        return FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.delete_forever),
          onPressed: () => controller.clearAll(),
        );
      }),
    );
  }
}
