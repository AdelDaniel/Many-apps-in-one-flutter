import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'courses_data.dart';
import 'widgets.dart';

class CoursesPage extends StatelessWidget {
  static const String routeName = "/Coursespage";
  static Route route() => MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CoursesPage());
  const CoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Course> courses = Course.courses;
    return Scaffold(
      appBar: AppBar(
        leading: const ResponsiveVisibility(
            hiddenWhen: [Condition.largerThan(name: TABLET)],
            child: Icon(Icons.menu)),
        backgroundColor: Colors.lightBlue[800],
        centerTitle: true,
        title: const AppBarTitle(),
        actions: [
          const ResponsiveVisibility(
            visible: false,
            visibleWhen: [Condition.largerThan(name: TABLET)],
            child: MenuTextButton(text: 'Courses'),
          ),
          const ResponsiveVisibility(
            visible: false,
            visibleWhen: [Condition.largerThan(name: TABLET)],
            child: MenuTextButton(text: 'About'),
          ),
          IconButton(icon: const Icon(Icons.mark_email_read), onPressed: () {}),
          IconButton(icon: const Icon(Icons.logout_rounded), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          Text(
            'look at the Responsive Value Feature.',
            style: TextStyle(
              fontSize: ResponsiveValue(
                context,
                defaultValue: 40.0,
                valueWhen: const [
                  Condition.smallerThan(name: MOBILE, value: 20.0),
                  Condition.largerThan(name: TABLET, value: 60.0)
                ],
              ).value,
            ),
          ),
          const Center(child: PageHeader()),
          const SizedBox(height: 30),
          ResponsiveRowColumn(
            layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            rowMainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResponsiveRowColumnItem(
                  rowFlex: 1, child: CourseTile(course: courses[0])),
              ResponsiveRowColumnItem(
                  rowFlex: 1, child: CourseTile(course: courses[1])),
            ],
          ),
          const SizedBox(height: 10),
          const Center(child: SubscribeBlock()),
        ],
      ),
    );
  }
}
