# football_shop
README for Assignment 7
1. A widget tree is how Flutter builds the UI — every screen element is a widget arranged in a tree structure. Parent widgets control layout or logic, while child widgets handle smaller visual parts.

2. Widgets used in this project:

    - MaterialApp – wraps the entire app and applies Material Design.

    - Scaffold – provides the main page layout with an app bar and body.

    - AppBar – displays the title “Football Shop” at the top.

    - Padding, Column, Row, Center, SizedBox – handle spacing and positioning of elements.

    - Card / Material / InkWell – create clickable, styled buttons.

    - GridView – displays the feature buttons in a grid format.

    - Icon and Text – show button icons and labels.

    - SnackBar – displays a short message when a button is pressed.

3. MaterialApp is the root widget that sets up the app’s structure, theme, and navigation. It’s often the starting point because it manages the overall look and feel of the Flutter app.

4. A StatelessWidget is used when the UI doesn’t change (like a static info page), while a StatefulWidget is used when the UI updates dynamically (like a form or counter). Football Shop uses stateless widgets because the content is fixed and doesn’t rely on changing data.

5. BuildContext tells each widget where it is in the widget tree. It’s important for accessing theme data, navigation, and parent widgets. In the build() method, it connects the widget to its environment for proper rendering.

6. Hot reload instantly applies small code changes while keeping the app's current state. Hot restart reloads the entire app from the beginning, clearing all states and starting fresh.

README for Assignment 8
1. In Flutter, navigation works using a stack of routes. Navigator.push() adds a new page to the top of the stack, allowing the user to return to the previous page using the back button. Meanwhile, Navigator.pushReplacement() replaces the current page entirely, removing it from the stack so that the user cannot go back to it. In the Football Shop application, Navigator.push() is used when moving from the home page to the Add Product page so users can easily return. Navigator.pushReplacement() would be suitable after saving a product if we want to prevent returning to the form screen.

2. Flutter uses layout hierarchy widgets to provide consistent structure across screens. The Scaffold widget acts as the main layout container for each page. The AppBar appears at the top of every page and displays the app’s title, ensuring uniform appearance. The Drawer provides a side navigation menu so users can switch between Home and Add Product easily. Together, these widgets create a familiar and organized interface throughout the Football Shop app.

3. Several layout widgets improve readability and usability in forms. Padding adds spacing around elements so they do not touch screen edges. SingleChildScrollView ensures that long forms remain scrollable on smaller screens. Additionally, SizedBox provides spacing between fields to create a cleaner visual layout. In Football Shop’s Add Product page, these widgets help the form remain easy to read, accessible, and responsive across different device sizes.

4. Flutter’s ThemeData allows the application to define its color palette in one place. In the Football Shop app, primarySwatch: Colors.blue sets blue as the main brand color used across the app for elements like the AppBar and buttons. This creates visual consistency, improves the overall look, and reinforces brand identity. By managing theme colors centrally, the app remains easier to maintain and style as it grows.