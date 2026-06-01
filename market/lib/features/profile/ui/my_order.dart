import 'package:flutter/material.dart';

class Order {
  final String id;
  final DateTime date;
  final String status;
  final double total;
  final int itemsCount;

  Order({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.itemsCount,
  });
}

final List<Order> sampleOrders = [
  Order(
    id: '#1001',
    date: DateTime.now().subtract(Duration(days: 2)),
    status: 'Delivered',
    total: 29.99,
    itemsCount: 3,
  ),
  Order(
    id: '#1002',
    date: DateTime.now().subtract(Duration(days: 7)),
    status: 'Shipped',
    total: 59.50,
    itemsCount: 5,
  ),
  Order(
    id: '#1003',
    date: DateTime.now().subtract(Duration(days: 14)),
    status: 'Processing',
    total: 12.75,
    itemsCount: 1,
  ),
];

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: sampleOrders.isEmpty
            ? const Center(
                child: Text(
                  'You have no orders yet.',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.separated(
                itemCount: sampleOrders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final order = sampleOrders[index];
                  return OrderCard(order: order);
                },
              ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  Color _statusColor(String status, BuildContext context) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'shipped':
        return Colors.orange;
      case 'processing':
        return Theme.of(context).colorScheme.primary;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: InkWell(
        onTap: () {
          // TODO: navigate to order details
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withOpacity(0.1),
                child: Text(
                  order.itemsCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.id,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatDate(order.date),
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${order.total.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Chip(
                    label: Text(
                      order.status,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    backgroundColor: _statusColor(order.status, context),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }
}
