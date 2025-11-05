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

6. Hot reload instantly applies small code changes while keeping the app’s current state. Hot restart reloads the entire app from the beginning, clearing all states and starting fresh.
