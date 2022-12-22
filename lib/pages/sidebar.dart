import 'package:flutter/material.dart';
import 'package:past_paper_master/colors.dart';
import 'package:past_paper_master/twotones.dart';

class SidebarView extends StatelessWidget {
  const SidebarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          SidebarItem(
              isActive: true, iconName: 'file-filter', title: 'Paper Filter'),
          SidebarItem(
              isActive: false, iconName: 'folder-browse', title: 'Browse'),
          SidebarItem(isActive: false, iconName: 'checkout', title: 'Checkout'),
          SidebarItem(
              isActive: false, iconName: 'download', title: 'Downloads'),
          SidebarItem(
              isActive: false,
              iconName: 'question-search',
              title: 'Search Questions'),
          SidebarItem(
              isActive: false, iconName: 'code', title: 'Pseudocode Runner'),
          Spacer(),
          SidebarItem(isActive: false, iconName: 'settings', title: 'Settings'),
          SidebarItem(isActive: false, iconName: 'info', title: 'About'),
          SizedBox(height: 24),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MColors.accent.shade50,
              ),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Public Alpha Test',
                      style: TextStyle(
                          color: MColors.accent.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text(
                      'Thank you for participating in Past Paper Master public alpha test!',
                      style: TextStyle(
                          color: MColors.accent.shade600,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text('Dismiss',
                          style: TextStyle(
                              color: MColors.accent.shade500,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 16),
                      Text('View details',
                          style: TextStyle(
                              color: MColors.accent.shade700,
                              fontSize: 14,
                              fontWeight: FontWeight.w500))
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  const SidebarItem(
      {required this.isActive,
      required this.iconName,
      required this.title,
      super.key});

  final bool isActive;
  final String iconName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isActive ? MColors.accent.shade50 : MColors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        twoToneIcon(iconName, isActive),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
              color: isActive ? MColors.accent.shade700 : MColors.grey.shade700,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        )
      ]),
    );
  }
}
