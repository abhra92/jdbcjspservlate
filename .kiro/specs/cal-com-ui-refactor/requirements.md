# Requirements Document

## Introduction

This specification defines the requirements for refactoring the Student Management System's UI from its current purple gradient-based design to the Cal.com monochrome utility design system. The refactoring scope is limited to the four JSP pages (index.jsp, students.jsp, student-form.jsp, student-detail.jsp) and their inline CSS. The backend (Servlets, DAO, database) remains unchanged.

## Glossary

- **UI_Layer**: The set of JSP pages (index.jsp, students.jsp, student-form.jsp, student-detail.jsp) and their inline CSS that render the Student Management System in the browser.
- **Design_System**: The Cal.com visual language defined by a monochrome color palette, specific typography (Cal Sans, Inter), pill-shaped buttons, subtle shadows, and compact density layout.
- **Color_Palette**: The set of named colors used across the UI — Ink (#101010), Graphite (#242424), Slate (#6b7280), Paper (#f4f4f4), White (#ffffff), Silver (#e5e7eb), and Action Blue (#0099ff).
- **Typography_Stack**: The font hierarchy consisting of Inter (headings at weight 600, body text at weight 300 with negative tracking, labels at weight 400-500).
- **Card_Component**: A white-background container with 12px border radius, 24px padding, and a subtle shadow (rgba(34, 42, 53, 0.05) 0px 4px 8px 0px) used to group related content.
- **Primary_CTA**: A pill-shaped button (9999px radius) with Ink (#101010) background and White (#ffffff) text used for main actions.
- **Secondary_CTA**: A pill-shaped outline button (9999px radius) with transparent background, Silver (#e5e7eb) border, and Graphite (#242424) text used for secondary actions.
- **Landing_Page**: The index.jsp page serving as the application entry point with feature cards and navigation.
- **Student_List_Page**: The students.jsp page displaying all students in a table with statistics and action buttons.
- **Student_Form_Page**: The student-form.jsp page used for adding and editing student records.
- **Student_Detail_Page**: The student-detail.jsp page displaying individual student information.

## Requirements

### Requirement 1: Global Color Palette Replacement

**User Story:** As a developer, I want all pages to use the Cal.com monochrome color palette, so that the application has a consistent, modern monochrome aesthetic.

#### Acceptance Criteria

1. THE UI_Layer SHALL use Paper (#f4f4f4) as the page background color on all pages.
2. THE UI_Layer SHALL use White (#ffffff) as the background color for all Card_Components.
3. THE UI_Layer SHALL use Graphite (#242424) as the color for all headings (h1, h2, h3) and paragraph body text.
4. THE UI_Layer SHALL use Slate (#6b7280) as the color for all helper text, metadata labels, and descriptive captions that are not headings or paragraph body text.
5. THE UI_Layer SHALL use Silver (#e5e7eb) as the color for all borders and dividers.
6. THE UI_Layer SHALL use Action Blue (#0099ff) exclusively for non-navigation hyperlinks and status indicator text that do not serve as primary or secondary action triggers.
7. THE UI_Layer SHALL NOT use any gradient backgrounds on any element.
8. THE UI_Layer SHALL use only colors defined in the Color_Palette (Ink, Graphite, Slate, Paper, White, Silver, Action Blue) for all CSS color, background-color, and border-color declarations, including hover, focus, and active states.
9. IF an interactive element is in a disabled state, THEN THE UI_Layer SHALL render it using Slate (#6b7280) text on a Paper (#f4f4f4) background with a Silver (#e5e7eb) border.

### Requirement 2: Typography System Implementation

**User Story:** As a developer, I want the application to use the Cal.com typography stack, so that text rendering matches the design system's clean, modern appearance.

#### Acceptance Criteria

1. THE UI_Layer SHALL load Inter (weights 300, 400, 500, 600) from Google Fonts or a CDN on all pages, with a fallback font-family of -apple-system, BlinkMacSystemFont, sans-serif.
2. THE UI_Layer SHALL render all headings (h1, h2, h3) using Inter at weight 600 with letter-spacing between +0.01em and +0.03em.
3. THE UI_Layer SHALL render all body text (paragraphs, table cells, and general content at 16px or 18px in the type scale) using Inter at weight 300 with negative letter-spacing between -0.19px and -0.24px.
4. THE UI_Layer SHALL render all labels (form labels, field descriptors) and captions (12px and 14px type scale elements) using Inter at weight 400 for captions and weight 500 for labels.
5. THE UI_Layer SHALL use the type scale: 12px (captions), 14px (body-sm), 16px (body), 18px (subheading), 20px (heading-sm), 24px (heading), 48px (heading-lg).
6. THE UI_Layer SHALL NOT use Segoe UI, Tahoma, Geneva, or Verdana as the first entry in any font-family declaration.
7. IF the Inter font fails to load from the external source, THEN THE UI_Layer SHALL render text using the fallback font-family (-apple-system, BlinkMacSystemFont, sans-serif) without breaking page layout or readability.

### Requirement 3: Button Component Restyling

**User Story:** As a developer, I want all buttons to follow the Cal.com button patterns, so that interactive elements have a consistent, refined appearance.

#### Acceptance Criteria

1. THE UI_Layer SHALL render all primary action buttons as pill-shaped (9999px border-radius) with Ink (#101010) background, White (#ffffff) text, 14px font-size, and weight 500.
2. THE UI_Layer SHALL render all secondary/cancel buttons as pill-shaped (9999px border-radius) with transparent background, 1px Silver (#e5e7eb) border, Graphite (#242424) text, 14px font-size, and weight 500.
3. THE UI_Layer SHALL render all inline action buttons (View, Edit, Delete in tables) as rectangular (8px border-radius) with Ink (#101010) background, White (#ffffff) text, 12px font-size, and weight 500.
4. THE UI_Layer SHALL use 12px vertical and 24px horizontal padding for pill-shaped buttons.
5. THE UI_Layer SHALL use 8px vertical and 16px horizontal padding for rectangular inline buttons.
6. THE UI_Layer SHALL NOT use colored backgrounds (blue, orange, red) on action buttons.
7. WHEN a user hovers over a Primary_CTA, THE UI_Layer SHALL apply a shadow of rgba(36, 36, 36, 0.7) 0px 1px 5px -4px without vertical translation, with a transition duration of 200ms.
8. WHEN a user hovers over a Secondary_CTA, THE UI_Layer SHALL change the border color to Graphite (#242424) with a transition duration of 200ms.
9. WHEN a user hovers over an inline action button, THE UI_Layer SHALL change the background color to Graphite (#242424) with a transition duration of 200ms.

### Requirement 4: Card Component Standardization

**User Story:** As a developer, I want all content containers to use the Cal.com card pattern, so that the layout has a quiet, layered appearance.

#### Acceptance Criteria

1. THE UI_Layer SHALL render all Card_Components with a White (#ffffff) background and a 12px border-radius.
2. THE UI_Layer SHALL apply a box-shadow of rgba(34, 42, 53, 0.05) 0px 4px 8px 0px to all Card_Components.
3. THE UI_Layer SHALL use 24px padding inside all Card_Components.
4. THE UI_Layer SHALL NOT apply any border property to Card_Component container elements for visual separation; borders on child elements within a Card_Component (such as form inputs or table dividers) are permitted.
5. THE UI_Layer SHALL NOT apply any box-shadow to Card_Components where the opacity exceeds 0.05 or the blur-radius exceeds 8px or the vertical offset exceeds 4px.
6. THE UI_Layer SHALL apply a minimum vertical margin of 16px between adjacent Card_Components.

### Requirement 5: Landing Page Refactoring

**User Story:** As a developer, I want the landing page (index.jsp) to follow the Cal.com layout patterns, so that the first impression matches the target design system.

#### Acceptance Criteria

1. THE Landing_Page SHALL display a horizontally centered layout with a maximum width of 1200px and minimum horizontal padding of 20px on each side.
2. THE Landing_Page SHALL display a headline using Inter at 48px, weight 600, color Graphite (#242424), with line-height 1.1.
3. THE Landing_Page SHALL display a subtitle below the headline using Inter at 16px, weight 300, color Slate (#6b7280), with line-height 1.6.
4. THE Landing_Page SHALL display feature cards in a 2-column grid layout with 24px gap between cards, each card following the Card_Component specification.
5. THE Landing_Page SHALL display the main navigation link ("Go to Student List") as a Primary_CTA pill button and all other navigation links ("Add New Student", "Student Details") as Secondary_CTA pill buttons.
6. THE Landing_Page SHALL display the technology stack section as a Card_Component with Graphite (#242424) text instead of a colored background block.
7. THE Landing_Page SHALL NOT use emoji characters in headings or button labels.

### Requirement 6: Student List Page Refactoring

**User Story:** As a developer, I want the student list page (students.jsp) to use Cal.com table and card patterns, so that data presentation is clean and functional.

#### Acceptance Criteria

1. THE Student_List_Page SHALL display the statistics section as a Card_Component with Graphite (#242424) text on a White (#ffffff) background.
2. THE Student_List_Page SHALL render the data table with a White (#ffffff) background, 1px Silver (#e5e7eb) row dividers, and Graphite (#242424) text.
3. THE Student_List_Page SHALL render the table header row with Paper (#f4f4f4) background and Graphite (#242424) text instead of a colored background.
4. THE Student_List_Page SHALL display the "Add New Student" button as a Primary_CTA pill button.
5. THE Student_List_Page SHALL display row action buttons (View, Edit, Delete) as rectangular buttons (8px border-radius) with Ink (#101010) background and White (#ffffff) text.
6. THE Student_List_Page SHALL NOT use emoji characters in button labels, table content, or alert messages.
7. WHEN a student row is hovered, THE Student_List_Page SHALL apply a Paper (#f4f4f4) background to the row.
8. IF no student records exist, THEN THE Student_List_Page SHALL display an empty state message inside a Card_Component using Slate (#6b7280) text with a link to the student form page.
9. WHEN a CRUD operation completes with a success or error message parameter, THE Student_List_Page SHALL display the message in a Card_Component using Graphite (#242424) text on a White (#ffffff) background with a 1px Silver (#e5e7eb) border.

### Requirement 7: Student Form Page Refactoring

**User Story:** As a developer, I want the student form page (student-form.jsp) to use Cal.com form patterns, so that data entry is clean and focused.

#### Acceptance Criteria

1. THE Student_Form_Page SHALL render form inputs with an 8px border-radius, 1px Silver (#e5e7eb) border, and 12px padding.
2. WHEN a form input receives focus, THE Student_Form_Page SHALL change the input border color to Ink (#101010) and remove any box-shadow or outline.
3. THE Student_Form_Page SHALL render the submit button as a Primary_CTA pill button with a text-only label ("Add Student" in add mode, "Update Student" in edit mode) and no emoji characters.
4. THE Student_Form_Page SHALL render the cancel button as a Secondary_CTA pill button with the label "Cancel" and no emoji characters.
5. THE Student_Form_Page SHALL render form labels using Inter at 14px, weight 500, color Graphite (#242424).
6. THE Student_Form_Page SHALL display the form inside a Card_Component centered horizontally on the page with a maximum width of 500px.
7. THE Student_Form_Page SHALL NOT use emoji characters in button labels or headings.
8. IF a form submission error is present, THEN THE Student_Form_Page SHALL display the error message inside a container with Paper (#f4f4f4) background, 8px border-radius, 12px padding, and Graphite (#242424) text.

### Requirement 8: Student Detail Page Refactoring

**User Story:** As a developer, I want the student detail page (student-detail.jsp) to use Cal.com detail patterns, so that individual records are presented cleanly.

#### Acceptance Criteria

1. THE Student_Detail_Page SHALL display student information inside a Card_Component centered on the page with a maximum width of 500px.
2. THE Student_Detail_Page SHALL render field labels using Inter at 12px, weight 500, color Slate (#6b7280), with uppercase text-transform and letter-spacing of 0.5px.
3. THE Student_Detail_Page SHALL render field values using Inter at 18px, weight 300, color Graphite (#242424), with letter-spacing of -0.2px.
4. THE Student_Detail_Page SHALL use a 1px border-bottom in Silver (#e5e7eb) as the separator between detail groups, except for the last detail group which SHALL have no border-bottom.
5. THE Student_Detail_Page SHALL display the student name header section as a Card_Component with Ink (#101010) background, the student name in White (#ffffff) at 24px weight 600, and the student ID in White (#ffffff) at 14px weight 300.
6. THE Student_Detail_Page SHALL render the Edit button as a Primary_CTA pill button, and the Delete and Back buttons as Secondary_CTA pill buttons.
7. THE Student_Detail_Page SHALL NOT use emoji characters in labels or button text.
8. IF the student record is not found, THEN THE Student_Detail_Page SHALL display an error message indicating the student does not exist and a Secondary_CTA pill button linking back to the student list.

### Requirement 9: Responsive Layout Preservation

**User Story:** As a developer, I want the refactored UI to remain responsive across screen sizes, so that the application works on all devices.

#### Acceptance Criteria

1. THE UI_Layer SHALL maintain a centered layout with a maximum width of 1200px on all pages, supporting viewport widths down to 320px without content overflow or clipping.
2. IF the viewport width is narrower than 768px, THEN THE UI_Layer SHALL collapse multi-column grid layouts to a single-column stack.
3. THE UI_Layer SHALL maintain a minimum font size of 14px for body text and 12px for captions and labels on all viewport widths.
4. IF the viewport width is narrower than the rendered width of a data table, THEN THE UI_Layer SHALL enable horizontal scrolling on the table container while keeping the surrounding page layout fixed.
5. WHILE the viewport width is narrower than 768px, THE UI_Layer SHALL render all interactive elements (buttons, links, form inputs) with a minimum touch-target size of 44px in both height and width.
6. WHILE the viewport width is narrower than 768px, THE UI_Layer SHALL reduce Card_Component padding from 24px to 16px.

### Requirement 10: Backend Compatibility Preservation

**User Story:** As a developer, I want the UI refactoring to preserve all existing backend interactions, so that CRUD operations continue to function without modification.

#### Acceptance Criteria

1. THE UI_Layer SHALL submit add and update forms using HTTP POST method to the form action URLs "student?action=add" and "student?action=update" respectively.
2. THE UI_Layer SHALL preserve all existing form input names (id, name, age, email), where "id" is submitted as a hidden field during update operations.
3. THE UI_Layer SHALL preserve all existing navigation links using HTTP GET method for the URLs: "student?action=list", "student?action=view&id={id}", "student?action=edit&id={id}", and "student?action=delete&id={id}".
4. THE UI_Layer SHALL read the "students" list and "student" object from request attributes (set via request.setAttribute), and read "error" and "success" messages from URL query parameters (accessed via request.getParameter).
5. WHEN the user clicks a delete action link, THE UI_Layer SHALL display a JavaScript confirmation dialog, and SHALL prevent navigation to the delete URL if the user cancels the dialog.
