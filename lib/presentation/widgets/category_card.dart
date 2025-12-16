import 'package:dil_se_khareedo/presentation/state/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
 @override
Widget build(BuildContext context) {
  return Consumer<CategoryProvider>(
    builder: (context, provider, _) {
      final isSelected = provider.selectedCategory == category.id;

      return GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  category.image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      );
    },
  );
}

}
