// lib/widgets/transaction_item.dart
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  // --- pilih ikon berdasar kategori ---
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.fastfood_rounded;
      case 'travel':
        return Icons.directions_car_rounded;
      case 'health':
        return Icons.health_and_safety_rounded;
      case 'event':
        return Icons.event_available_rounded;
      case 'income':
        return Icons.attach_money_rounded;
      default:
        return Icons.payments_rounded;
    }
  }

  // --- pilih warna gradasi per kategori ---
  List<Color> _getCategoryGradient(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return [const Color(0xFFFFE4C4), const Color(0xFFFFC285)];
      case 'travel':
        return [const Color(0xFFC2E9FB), const Color(0xFFA1C4FD)];
      case 'health':
        return [const Color(0xFFB2F2BB), const Color(0xFF74C69D)];
      case 'event':
        return [const Color(0xFFE4C1F9), const Color(0xFFB298DC)];
      case 'income':
        return [const Color(0xFFB9FBC0), const Color(0xFF98F5E1)];
      default:
        return [const Color(0xFFDDE9FF), const Color(0xFFB6CCFE)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.amount.startsWith('-');
    final icon = _getCategoryIcon(transaction.category);
    final gradient = _getCategoryGradient(transaction.category);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: gradient.last.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Color(0xFF1E293B),
          ),
        ),
        subtitle: Text(
          transaction.category,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        trailing: Text(
          transaction.amount,
          style: TextStyle(
            color: isExpense
                ? const Color(0xFFE04A4A)
                : const Color(0xFF1AAE5E),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
