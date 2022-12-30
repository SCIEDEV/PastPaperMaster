import 'package:flutter/material.dart';
import 'package:past_paper_master/colors.dart';
import 'package:past_paper_master/provider.dart';
import 'package:past_paper_master/components/twotones.dart';
import 'package:provider/provider.dart';

class SidebarView extends StatelessWidget {
  const SidebarView({super.key});

  static List<dynamic> _sidebarDataTop = [
    {'icon': 'file-filter', 'title': 'Paper Filter'},
    {'icon': 'folder-browse', 'title': 'Browse'},
    {'icon': 'checkout', 'title': 'Checkout'},
    {'icon': 'download', 'title': 'Downloads'},
    {'icon': 'question-search', 'title': 'Search Questions'},
    {'icon': 'code', 'title': 'Pseudocode Runner'},
  ];

  static List<dynamic> _sidebarDataBottom = [
    {'icon': 'settings', 'title': 'Settings'},
    {'icon': 'info', 'title': 'About'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          ...[
            for (var item in _sidebarDataTop)
              SidebarItem(
                  isActive: context.watch<GeneralStates>().selectedTab ==
                      _sidebarDataTop.indexOf(item),
                  iconName: item['icon'],
                  title: item['title'],
                  index: _sidebarDataTop.indexOf(item))
          ],
          Spacer(),
          ...[
            for (var item in _sidebarDataBottom)
              SidebarItem(
                  isActive: context.watch<GeneralStates>().selectedTab ==
                      _sidebarDataTop.length + _sidebarDataBottom.indexOf(item),
                  iconName: item['icon'],
                  title: item['title'],
                  index:
                      _sidebarDataTop.length + _sidebarDataBottom.indexOf(item))
          ],
          if (context.watch<GeneralStates>().showAlphaBanner) ...[
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
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            context.read<GeneralStates>().showAlphaBanner =
                                false;
                          },
                          child: Text('Dismiss',
                              style: TextStyle(
                                  color: MColors.accent.shade500,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {},
                          child: Text('View details',
                              style: TextStyle(
                                  color: MColors.accent.shade700,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        )
                      ],
                    )
                  ],
                ))
          ]
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
      super.key,
      required this.index});

  final bool isActive;
  final String iconName;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        context.read<GeneralStates>().selectedTab = index;
      },
      fillColor: isActive ? MColors.accent.shade50 : MColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(children: [
          twoToneIcon(iconName, isActive),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
                color:
                    isActive ? MColors.accent.shade700 : MColors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )
        ]),
      ),
    );
  }
}
