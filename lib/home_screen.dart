import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:site/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: DrawerWidget()),
      appBar: (Responsive.isMobile(context))
          ? AppBar(
              toolbarHeight: 140,
              backgroundColor: Colors.white,
              elevation: 5,
              title: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GreetingText(
                      user: 'Ryan',
                      timeOfDay: 'Morning',
                      fontSize: 20,
                    ),
                    SizedBox(height: 4.0),
                    SearchField(),
                  ],
                ),
              ),
              leading: LeadingMenuButton(),
            )
          : null,
      backgroundColor: Colors.white,
      body: Responsive.isMobile(context) ? MobileView() : WideScreenView(),
    );
  }
}

class LeadingMenuButton extends StatelessWidget {
  const LeadingMenuButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.menu,
        color: Colors.black,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({Key? key}) : super(key: key);
  static const _list = <Widget>[
    SizedBox(
      height: 320,
      child: CurvedLineChart(),
    ),
    SizedBox(
      height: 250,
      child: StatusCard(),
    ),
    SizedBox(
      height: 350,
      child: TeamMembersCard(),
    ),
    SizedBox(
      height: 300,
      child: PriorityProjectsWidget(),
    ),
    SizedBox(
      height: 350,
      child: MyProjectsWidget(),
    ),
    SizedBox(
      height: 130,
      child: UpgradeCard(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        child: _list[index],
      ),
      itemCount: _list.length,
    );
  }
}

class WideScreenView extends StatelessWidget {
  const WideScreenView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (Responsive.isDesktop(context))
          Expanded(
            flex: 1,
            child: DrawerWidget(),
          ),
        if (Responsive.isTablet(context))
          Expanded(
            flex: 1,
            child: MiniDrawerWidget(),
          ),
        Expanded(
          flex: Responsive.isTablet(context) ? 12 : 4,
          child: Column(
            children: [
              Expanded(
                  flex: Responsive.isTablet(context) ? 2 : 1,
                  child: WindowHeader()),
              Expanded(
                flex: Responsive.isTablet(context) ? 14 : 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: Responsive.isTablet(context)
                                  ? MediaQuery.of(context).size.height * 1.8
                                  : MediaQuery.of(context).size.height * 1.2,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: Row(
                                      children: [
                                        (!Responsive.isTablet(context))
                                            ? SizedBox(
                                                width: constraints.maxWidth *
                                                    2 /
                                                    3,
                                                child: CenterView(),
                                              )
                                            : Expanded(
                                                child: CenterView(),
                                              ),
                                        SizedBox(width: 15.0),
                                        if (!Responsive.isTablet(context))
                                          SizedBox(
                                            width:
                                                constraints.maxWidth * 1 / 3 -
                                                    15.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0,
                                              ),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: StatusCard(),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: TeamMembersCard(),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: UpgradeCard(),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CenterView extends StatelessWidget {
  const CenterView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: CurvedLineChart(),
        ),
        SizedBox(height: 20.0),
        if (Responsive.isTablet(context))
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: StatusCard(),
                ),
                SizedBox(width: 30.0),
                Expanded(
                  child: TeamMembersCard(),
                ),
              ],
            ),
          ),
        SizedBox(height: 20.0),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                flex: (Responsive.isTablet(context)) ? 1 : 7,
                child: MyProjectsWidget(),
              ),
              SizedBox(width: 30.0),
              Expanded(
                flex: (Responsive.isTablet(context)) ? 1 : 5,
                child: PriorityProjectsWidget(),
              ),
            ],
          ),
        ),
        if (Responsive.isTablet(context)) SizedBox(height: 20.0),
        if (Responsive.isTablet(context))
          SizedBox(
            height: 120,
            child: UpgradeCard(),
          ),
      ],
    );
  }
}

class MiniDrawerWidget extends StatelessWidget {
  const MiniDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 30,
              child: FlutterLogo(size: 40),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              MiniTileButton(
                title: 'Dashboard',
                icon: CupertinoIcons.home,
                isSelected: true,
              ),
              SizedBox(height: 15.0),
              MiniTileButton(
                title: 'Members',
                icon: CupertinoIcons.group,
                isSelected: false,
              ),
              SizedBox(height: 15.0),
              MiniTileButton(
                title: 'Messages',
                icon: Icons.message,
                isSelected: false,
              ),
              SizedBox(height: 15.0),
              MiniTileButton(
                title: 'Labels',
                icon: Icons.label_important_outline_rounded,
                isSelected: false,
              ),
              SizedBox(height: 15.0),
              MiniTileButton(
                title: 'Reports',
                icon: CupertinoIcons.clock,
                isSelected: false,
              ),
              Spacer(),
            ],
          ),
        ),
        Expanded(
          child: Responsive.isTablet(context)
              ? Column(
                  children: [
                    MiniTileButton(
                      title: 'Logout',
                      icon: Icons.logout,
                      isSelected: true,
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: BackgroundIcon(
                      icon: Icons.logout,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class MiniTileButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isSelected;

  const MiniTileButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.isSelected,
  }) : super(key: key);

  @override
  _MiniTileButtonState createState() => _MiniTileButtonState();
}

class _MiniTileButtonState extends State<MiniTileButton> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35.0),
      child: MouseRegion(
        onHover: (event) {
          setState(() {
            _isHovering = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHovering = false;
          });
        },
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
          color: widget.isSelected
              ? Colors.green[700]!.withBlue(80)
              : _isHovering
                  ? Colors.green[100]
                  : Colors.white,
          child: IconButton(
            padding: const EdgeInsets.all(12.0),
            mouseCursor: MouseCursor.defer,
            tooltip: widget.title,
            onPressed: () {},
            icon: Icon(
              widget.icon,
              color: widget.isSelected
                  ? Colors.white
                  : _isHovering
                      ? Colors.white
                      : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DrawerTopWidget(),
        ),
        Expanded(
          flex: 3,
          child: DrawerBottomWidget(),
        ),
      ],
    );
  }
}

class UpgradeCard extends StatelessWidget {
  const UpgradeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.green[800],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green[700],
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Icon(
                Icons.upgrade_rounded,
                size: 80.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'More productivity with premium mode',
                  style: GoogleFonts.montserrat(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
                TextButton(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.green[700]),
                  ),
                  child: Text(
                    'UPGRADE',
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (Responsive.isTablet(context))
          ? EdgeInsets.all(0.0)
          : EdgeInsets.only(bottom: 15.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: (Responsive.isTablet(context))
              ? EdgeInsets.all(0.0)
              : EdgeInsets.all(5.0),
          child: Column(
            children: [
              ProgressCard(
                color: Colors.green,
                progress: 30,
                comment: 'Completed',
                percents: [0.3, 0.6, 0.9],
                delta: 5.7,
              ),
              ProgressCard(
                color: Colors.red,
                progress: 14,
                comment: 'Uncompleted',
                percents: [0.4, 0.7, 0.5],
                delta: 2.1,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TeamMembersCard extends StatelessWidget {
  const TeamMembersCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Responsive.isTablet(context)
          ? EdgeInsets.only(top: 5.0, bottom: 5.0)
          : EdgeInsets.only(top: 10.0, bottom: 30.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Team Members',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
              ],
            ),
            TeamMemberTile(
              name: 'Fufu Kafulifu',
              role: 'UI Designer',
            ),
            TeamMemberTile(
              name: 'Clark Griffin',
              role: 'UX Researcher',
            ),
            TeamMemberTile(
              name: 'Octavia Blake',
              role: 'Copywriter',
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: (Responsive.isTablet(context)) ? 0.0 : 10.0),
                  child: Text(
                    'See all teams',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.0,
                      color: Colors.green[800],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamMemberTile extends StatelessWidget {
  final String name;
  final String role;
  const TeamMemberTile({
    Key? key,
    required this.name,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.comfortable,
      leading: CircleAvatar(
        radius: 30,
        child: FlutterLogo(size: 40),
      ),
      title: Text(
        name,
        style: GoogleFonts.montserrat(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        role,
        style: GoogleFonts.montserrat(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {},
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  final ColorSwatch color;
  final double progress;
  final double delta;
  final String comment;
  final List<double> percents;
  const ProgressCard({
    Key? key,
    required this.color,
    required this.progress,
    required this.comment,
    required this.percents,
    required this.delta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.symmetric(
          vertical: 25.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: ProgressChart(percents: percents, color: color),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$progress',
                      style: GoogleFonts.montserrat(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '+',
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: FittedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment,
                      style: GoogleFonts.montserrat(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: color[100],
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: RichText(
                        text: TextSpan(
                            text: color == Colors.red ? '↓' : '↑',
                            style: GoogleFonts.montserrat(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                              color: color,
                            ),
                            children: [
                              TextSpan(
                                text: '$delta',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w600,
                                  color: color,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressChart extends StatelessWidget {
  final List<double> percents;
  final Color color;
  const ProgressChart({
    Key? key,
    required this.percents,
    required this.color,
  })   : assert(percents.length == 3),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Spacer(flex: 4),
            ProgressBar(
              maxHeight: constraints.maxHeight,
              percent: percents[0],
              color: color,
            ),
            const Spacer(),
            ProgressBar(
              maxHeight: constraints.maxHeight,
              percent: percents[1],
              color: color,
            ),
            const Spacer(),
            ProgressBar(
              maxHeight: constraints.maxHeight,
              percent: percents[2],
              color: color,
            ),
            const Spacer(flex: 4),
          ],
        );
      },
    );
  }
}

class ProgressBar extends StatelessWidget {
  final double maxHeight;
  final double percent;
  final Color color;
  const ProgressBar({
    Key? key,
    required this.maxHeight,
    required this.percent,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxHeight * percent,
      width: 6.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class PriorityProjectsWidget extends StatelessWidget {
  const PriorityProjectsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Priority Projects',
            style: GoogleFonts.montserrat(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create design system for mobile and website',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                      Text(
                        'Jun 25, 2020',
                        style: GoogleFonts.montserrat(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ProgressIndicator(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: CustomPaint(
        painter: ProgressPainter(isMobile: Responsive.isMobile(context)),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '75',
                style: GoogleFonts.montserrat(
                  fontSize: Responsive.isMobile(context) ? 25.0 : 40.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                '%',
                style: GoogleFonts.montserrat(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final bool isMobile;

  ProgressPainter({this.isMobile = false});

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final w = size.width;
    final l = min(h, w);

    final startAngle = 0.0;
    final sweepAngle = 3 * pi / 2;
    final rect =
        Rect.fromCenter(center: Offset(w / 2, h / 2), width: l, height: l);
    final Paint paint = Paint()
      ..strokeWidth = isMobile ? 15.0 : 40.0
      ..style = PaintingStyle.stroke
      ..shader = SweepGradient(
        colors: [Colors.white, Colors.red, Colors.white],
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
      ).createShader(rect);
    canvas.drawArc(rect.deflate(30), startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(ProgressPainter oldDelegate) {
    return oldDelegate.isMobile != isMobile;
  }
}

class MyProjectsWidget extends StatelessWidget {
  const MyProjectsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Projects',
                  style: GoogleFonts.montserrat(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 10.0),
            ProjectTile(
              title: 'Priority',
              content: 'Create design system for mobile app and website',
              color: Colors.pink,
            ),
            SizedBox(height: 10.0),
            ProjectTile(
              title: 'Revision',
              content: 'Think of a better way to make the components simple',
              color: Colors.lightGreen,
            ),
            Spacer(),
            AddNewProjectButton(),
          ],
        ),
      ),
    );
  }
}

class AddNewProjectButton extends StatelessWidget {
  const AddNewProjectButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add,
          color: Colors.green[800],
        ),
        Text(
          'Add New Project',
          style: GoogleFonts.montserrat(
            fontSize: 16.0,
            color: Colors.green[800],
          ),
        ),
      ],
    );
  }
}

class ProjectTile extends StatelessWidget {
  final String title;
  final String content;
  final ColorSwatch color;
  const ProjectTile({
    Key? key,
    required this.title,
    required this.content,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: color[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bookmark_border_outlined, color: color),
              SizedBox(width: 10.0),
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  color: color,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            content,
            style: GoogleFonts.montserrat(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedLineChart extends StatelessWidget {
  const CurvedLineChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 5.0,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Activity',
                      style: GoogleFonts.montserrat(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (!Responsive.isMobile(context))
                  Spacer(flex: 3)
                else
                  SizedBox(width: 10.0),
                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChartChip(category: 'Daily'),
                      ChartChip(category: 'Weekly'),
                      ChartChip(category: 'Monthly'),
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: LineChart(
                LineChartData(
                  maxX: 7,
                  minX: 0,
                  maxY: 100,
                  minY: 0,
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: false,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: [
                        FlSpot(0, 55),
                        FlSpot(0.9, 75),
                        FlSpot(1.8, 35),
                        FlSpot(3, 98),
                        FlSpot(3.8, 28),
                        FlSpot(5, 73),
                        FlSpot(6.1, 46),
                        FlSpot(7, 74),
                      ],
                      colors: [Colors.green[800]!],
                      dotData: FlDotData(
                        show: false,
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => GoogleFonts.montserrat(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 30:
                            return '30';
                          case 50:
                            return '50';
                          case 70:
                            return '70';
                          case 100:
                            return '100';
                        }
                        return '';
                      },
                    ),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => GoogleFonts.montserrat(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'Jan';
                          case 1:
                            return 'Feb';
                          case 2:
                            return 'Mar';
                          case 3:
                            return 'Apr';
                          case 4:
                            return 'May';
                          case 5:
                            return 'Jun';
                          case 6:
                            return 'Jul';
                          case 7:
                            return 'Aug';
                        }
                        return '';
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartChip extends StatelessWidget {
  final String category;
  const ChartChip({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        category,
        style: GoogleFonts.montserrat(
          fontSize: 12.0,
        ),
      ),
    );
  }
}

class WindowHeader extends StatelessWidget {
  const WindowHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Responsive(
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GreetingText(timeOfDay: 'morning', user: 'Ryan'),
            SearchField(),
          ],
        ),
        mobile: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GreetingText(timeOfDay: 'morning', user: 'Ryan'),
            SearchField(),
          ],
        ),
        tablet: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingText(timeOfDay: 'morning', user: 'Ryan'),
            Spacer(),
            SearchField(),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width < 260
                ? MediaQuery.of(context).size.width - 20
                : 260,
            child: TextField(
              cursorHeight: 20,
              style: GoogleFonts.montserrat(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'Search projects',
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 5.0),
          BackgroundIcon(icon: Icons.search, padding: 10.0),
        ],
      ),
    );
  }
}

class GreetingText extends StatelessWidget {
  final String timeOfDay;
  final String user;
  final double fontSize;
  const GreetingText({
    Key? key,
    this.timeOfDay = 'time',
    this.user = 'User',
    this.fontSize = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Good $timeOfDay,  ',
        style: GoogleFonts.montserrat(
          fontSize: fontSize,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: '$user ☀️',
            style: GoogleFonts.montserrat(
              fontSize: 24.0,
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerBottomWidget extends StatefulWidget {
  const DrawerBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  _DrawerBottomWidgetState createState() => _DrawerBottomWidgetState();
}

class _DrawerBottomWidgetState extends State<DrawerBottomWidget> {
  final _isSelected = List<bool>.filled(5, false);
  @override
  void initState() {
    super.initState();
    _isSelected[0] = true;
  }

  void onTap() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        children: [
          TileItem(
            index: 0,
            text: 'Dashboard',
            icon: CupertinoIcons.home,
            isSelected: _isSelected,
            onTap: onTap,
          ),
          TileItem(
            index: 1,
            text: 'Members',
            icon: CupertinoIcons.group,
            isSelected: _isSelected,
            onTap: onTap,
          ),
          TileItem(
            index: 2,
            text: 'Messages',
            icon: Icons.message,
            isSelected: _isSelected,
            onTap: onTap,
          ),
          TileItem(
            index: 3,
            text: 'Labels',
            icon: Icons.label_important_outline_rounded,
            isSelected: _isSelected,
            onTap: onTap,
          ),
          TileItem(
            index: 4,
            text: 'Reports',
            icon: CupertinoIcons.clock,
            isSelected: _isSelected,
            onTap: onTap,
          ),
          Spacer(),
          LogOutTile(),
        ],
      ),
    );
  }
}

class LogOutTile extends StatelessWidget {
  const LogOutTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BackgroundIcon(icon: Icons.logout),
          SizedBox(width: 8.0),
          Text(
            'Log Out',
            style: GoogleFonts.montserrat(
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerTopWidget extends StatelessWidget {
  const DrawerTopWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            child: FlutterLogo(size: 40),
          ),
          SizedBox(height: 8.0),
          Text(
            'Ryan Risbaya',
            style: GoogleFonts.montserrat(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.0),
          Text(
            'UI/UX designer',
            style: GoogleFonts.montserrat(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundIcon extends StatelessWidget {
  final IconData icon;
  final double padding;
  final double size;
  final ColorSwatch backgroundColor;
  const BackgroundIcon({
    Key? key,
    required this.icon,
    this.padding = 12.0,
    this.size = 30,
    this.backgroundColor = Colors.green,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor[700]!.withBlue(80),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: size,
      ),
    );
  }
}

class TileItem extends StatefulWidget {
  final int index;
  final List<bool> isSelected;
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const TileItem({
    Key? key,
    required this.isSelected,
    required this.index,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  _TileItemState createState() => _TileItemState();
}

class _TileItemState extends State<TileItem> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          for (int i = 0; i < 5; i++)
            if (i != widget.index)
              widget.isSelected[i] = false;
            else
              widget.isSelected[i] = true;
          widget.onTap();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: ListTile(
            tileColor: widget.isSelected[widget.index]
                ? Colors.green[700]!.withBlue(80)
                : _isHovering
                    ? Colors.green[100]
                    : Colors.white,
            leading: Icon(
              widget.icon,
              color: widget.isSelected[widget.index]
                  ? Colors.white
                  : Colors.black54,
            ),
            title: MouseRegion(
              onHover: (hoverEvent) {
                setState(() {
                  _isHovering = true;
                });
              },
              onExit: (exitEvent) {
                setState(() {
                  _isHovering = false;
                });
              },
              child: Text(
                widget.text,
                style: TextStyle(
                    color: widget.isSelected[widget.index]
                        ? Colors.white
                        : Colors.black54),
              ),
            ),
            trailing: widget.isSelected[widget.index]
                ? Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(
                      Icons.circle,
                      size: 5,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
