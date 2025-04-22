# Travel Planner App - UI Requirements

## Design Overview

The Travel Planner app follows a modern, clean design inspired by contemporary travel applications. It uses a cohesive color scheme, consistent spacing, and carefully crafted UI components to provide an engaging and intuitive user experience.

## Color Palette

### Primary Colors
- **Primary Dark**: Deep Blue (#3A5896) - Used for emphasis and depth
- **Primary**: Medium Blue (#4B75CC) - Main brand color
- **Primary Light**: Light Blue (#6B9AFF) - Used for highlights and secondary elements

### Accent Colors
- **Accent**: Orange/Amber (#FFA651) - Used for call-to-action elements and highlights
- **Accent Dark**: Dark Orange (#E67D00) - Used for emphasis and depth in accent elements
- **Accent Light**: Light Orange (#FFD1A1) - Used for subtle accent backgrounds

### Neutrals
- **Black**: Dark Slate (#1D1E2C) - Used for text and primary content
- **Dark Grey**: Charcoal (#444655) - Used for secondary text and borders
- **Medium Grey**: Steel (#8E92A4) - Used for inactive elements and tertiary text
- **Light Grey**: Platinum (#D4D6E4) - Used for backgrounds and dividers
- **Off White**: Snow (#F7F8FC) - Used for background and card surfaces
- **White**: Pure White (#FFFFFF) - Used for text on dark backgrounds and card surfaces

### Semantic Colors
- **Success**: Green (#4CAF50) - Used for success states and confirmation
- **Warning**: Amber (#FFB74D) - Used for warning states and caution alerts
- **Error**: Red (#E57373) - Used for error states and critical alerts
- **Info**: Blue (#64B5F6) - Used for informational states and tips

## Typography

The app uses Poppins as the primary font family for all text elements. Text styles are categorized as follows:

### Headings
- **Heading XL**: 32px, Bold - Used for splash screens and primary headings
- **Heading L**: 28px, Bold - Used for screen titles and major sections
- **Heading M**: 24px, SemiBold - Used for section headings
- **Heading S**: 20px, SemiBold - Used for subsection headings
- **Heading XS**: 18px, SemiBold - Used for card titles and important content

### Body Text
- **Body L**: 16px, Regular - Used for primary content
- **Body M**: 14px, Regular - Used for secondary content and descriptions
- **Body S**: 12px, Regular - Used for tertiary content and metadata
- **Body XS**: 10px, Regular - Used for labels and fine print

### Buttons & Labels
- **Button L**: 16px, SemiBold - Used for primary buttons
- **Button M**: 14px, SemiBold - Used for secondary buttons
- **Button S**: 12px, SemiBold - Used for tertiary buttons
- **Caption**: 11px, Medium - Used for captions and supplementary information
- **Overline**: 10px, Medium, All Caps - Used for labels and category indicators

## Spacing & Dimensions

Consistent spacing is used throughout the app:

- **Padding XS**: 4px - Used for minimal spacing
- **Padding S**: 8px - Used for compact spacing
- **Padding M**: 16px - Used for standard spacing
- **Padding L**: 24px - Used for generous spacing
- **Padding XL**: 32px - Used for section separation
- **Padding XXL**: 48px - Used for major section separation

Border radius values:
- **Radius XS**: 4px - Used for small elements
- **Radius S**: 8px - Used for buttons and small cards
- **Radius M**: 12px - Used for input fields and medium-sized elements
- **Radius L**: 16px - Used for cards and large elements
- **Radius XL**: 24px - Used for featured cards and modals
- **Radius XXL**: 32px - Used for floating action buttons and large rounded corners
- **Radius Circular**: 100px - Used for circles and avatar images

## Components

### Cards
- White background with subtle shadow
- Rounded corners (Radius L: 16px)
- Proper padding and spacing for content
- Optional header with title and actions
- Support for various content types: text, images, lists

### Buttons
- **Primary**: Blue background with white text
- **Secondary**: Light grey background with dark text
- **Accent**: Orange background with white text
- All buttons have consistent height and padding
- Text is always centered
- Border radius M (12px)
- No elevation by default, subtle hover and active states

### Input Fields
- Light background (off-white)
- No border in normal state
- Colored border when focused
- Error state with red border and error message
- Always include labels
- Proper spacing between fields
- Optional icons for context

### Navigation
- Bottom navigation bar for primary navigation
- App bar for context-specific actions
- Drawer for additional options
- Consistent icons and labels
- Visual indication of current screen

## Screen Layouts

### Splash Screen
- Full-screen gradient background
- Centered logo with subtle animation
- App name and tagline
- Progress indicator

### Login/Register
- Curved top section with logo and app name
- Form fields with proper validation
- Primary action button at the bottom
- Link to toggle between login and register
- Error handling with clear messages

### Home Screen
- Welcome section with user name
- Recent/upcoming trips section
- Quick actions for creating new trips
- Inspiration section with destinations
- Bottom navigation

### Trip Details
- Cover image with trip title and dates
- Tab navigation for sections (Itinerary, Budget, Info)
- Action buttons for editing and sharing
- Timeline view for activities
- Weather information integration

### Settings/Profile
- User information section
- Preference toggles
- Account management options
- App information
- Logout option

## Design Principles

1. **Consistency**: Maintain consistent use of colors, typography, and spacing
2. **Hierarchy**: Use size, color, and weight to establish visual hierarchy
3. **Feedback**: Provide clear feedback for all user interactions
4. **Accessibility**: Ensure sufficient contrast and touch target sizes
5. **Simplicity**: Keep layouts clean and focused on content
6. **Delight**: Include subtle animations and transitions to enhance the experience

## Responsive Behavior

The app is designed to work on various screen sizes, with special consideration for:
- Small phones (320dp width)
- Standard phones (360-400dp width)
- Large phones (400-600dp width)
- Small tablets (600-840dp width)
- Tablets (840dp+ width)

Layouts will adapt using flexible grids and appropriate breakpoints.

## Dark Mode Support

The app supports both light and dark modes, with appropriate color adjustments for:
- Backgrounds (light to dark)
- Text (dark to light)
- Component colors (adjusted for contrast)
- Images and icons (with alternate versions where needed)

## Accessibility Guidelines

1. Color contrast meets WCAG 2.1 AA standards
2. Touch targets are at least 48x48dp
3. Text is resizable up to 200%
4. All interactive elements have descriptive labels
5. No information is conveyed by color alone
6. Animations can be disabled 