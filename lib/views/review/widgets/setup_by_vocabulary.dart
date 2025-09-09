import 'package:flutter/material.dart';

class SetupByVocabulary extends StatefulWidget {
  const SetupByVocabulary({super.key});

  @override
  State<SetupByVocabulary> createState() => _SetupByVocabularyState();
}

class _SetupByVocabularyState extends State<SetupByVocabulary> {
  final _formSearchKey = GlobalKey<FormState>();

  String _enterSearch = '';
  bool isShowAnswer = false;
  void _searchElement() {}

  Widget _searchInputWidget() {
    return Form(
      key: _formSearchKey,
      child: TextFormField(
        onChanged: (value) {
          _searchElement();
        },
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              width: 0.5,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              width: 0.5,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          hintText: "Tìm kiếm từ...",
          hintStyle: Theme.of(context).textTheme.bodySmall,
          suffixIcon: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              _searchElement();
            },
            icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          ),
        ),
        validator: (value) {
          if (value == null) {
            return "Vui lòng điền vào ô tìm kiếm";
          }

          return null;
        },
        onSaved: (value) {
          setState(() {
            _enterSearch = value!.trim();
          });
        },
      ),
    );
  }

  Widget _questionTypeCard({required String title}) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      color: Theme.of(context).colorScheme.secondary.withAlpha(15),
      child: ListTile(
        leading: const Icon(Icons.check_box_outline_blank),
        title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "1. Chọn Unit để ôn tập",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _searchInputWidget(),
            const SizedBox(height: 8),

            SizedBox(
              height: 200,
              width: double.infinity,
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),

                      margin: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withAlpha(15),
                      child: ListTile(
                        leading: const Icon(Icons.check_box_outline_blank),
                        title: Text(
                          "Từ ${index + 1}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "2. Chọn dạng câu hỏi",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _questionTypeCard(title: "Trắc nghiệm 4 đáp án"),
            _questionTypeCard(title: "Nghe & điền từ"),
            _questionTypeCard(title: "Điền từ có gợi ý"),
            _questionTypeCard(title: "Điền từ trong hội thoại"),
            _questionTypeCard(title: "Tìm vị trí từ trong câu"),
            _questionTypeCard(title: "Chọn phát âm đúng"),
            const SizedBox(height: 32),
            Text(
              "3. Tùy chỉnh",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              color: Theme.of(context).colorScheme.secondary.withAlpha(15),
              child: ListTile(
                title: Text(
                  "Hiển thị đáp án ngay",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Switch(
                  value: isShowAnswer,
                  onChanged: (value) {
                    setState(() {
                      isShowAnswer = value;
                    });
                  },
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              color: Theme.of(context).colorScheme.secondary.withAlpha(15),
              child: ListTile(
                title: Text(
                  "Giới hạn thời gian (phút)",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 70,
                  height: 40,
                  child: TextFormField(
                    initialValue: "15",
                    style: Theme.of(context).textTheme.bodyMedium,

                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      isDense: true, // làm gọn padding
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      final number = int.tryParse(value);
                      // xử lý số nhập vào
                    },
                  ),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              color: Theme.of(context).colorScheme.secondary.withAlpha(15),
              child: ListTile(
                title: Text(
                  "Số lượng câu hỏi",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 70,
                  height: 40,
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    initialValue: "15",
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      isDense: true, // làm gọn padding
                      filled: false,
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      final number = int.tryParse(value);
                      // xử lý số nhập vào
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Bắt đầu"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
