# Suggestions & Ideas

> Last Updated: 2026-01-12

---

## 💡 Architecture Suggestions

### 1. SaaS Multi-Tenancy

- Use `organizationId` field in all Firestore documents
- Implement row-level security with Firestore rules
- Create separate Super Admin web panel (Next.js)

### 2. State Management

- Consider ReplaySubject for undo functionality
- Add offline-first caching with Hive
- Implement proper error boundaries

### 3. Performance

- Add image caching with `cached_network_image`
- Implement lazy loading for property lists
- Use pagination for large data sets

---

## 🎨 UI/UX Suggestions

### 1. Design Consistency

- All buttons should use global widgets (PrimaryButton, SecondaryButton)
- Replace hardcoded Colors with theme colors
- Use AppConstants for all spacing

### 2. Animations

- Add micro-interactions to buttons
- Implement page transitions
- Add loading skeletons for better perceived performance

### 3. Accessibility

- Add semantic labels to all interactive elements
- Ensure proper contrast ratios
- Test with screen readers

---

## 🔧 Technical Debt

### High Priority

- Replace ~200 `withOpacity` calls with `withValues()` (deprecated)
- Add proper error handling in all controllers
- Implement proper loading states

### Medium Priority

- Add input validation to all forms
- Centralize API error messages
- Add rate limiting for authentication

### Low Priority

- Remove unused imports
- Add parameter documentation
- Refactor large widgets into smaller components

---

## 📱 Feature Ideas

### For Tenants

- [ ] Save search filters
- [ ] Compare properties side-by-side
- [ ] Virtual tour integration
- [ ] Push notifications for bookings

### For Owners

- [ ] Bulk property management
- [ ] Revenue reports export (PDF/Excel)
- [ ] Automated pricing suggestions
- [ ] Calendar sync (Google, Apple)

### For Admin

- [ ] Dashboard with real-time analytics
- [ ] Fraud detection alerts
- [ ] User verification workflow
- [ ] Automated reports

---

## 🛠 Development Workflow Suggestions

### Git Workflow

- Use feature branches: `feature/[name]`
- Use fix branches: `fix/[issue]`
- Always test before merging to main
- Write descriptive commit messages

### Code Review

- Both developers review each other's PRs
- Test on physical device before approval
- Check for console errors/warnings

### Documentation

- Update `.docs/` folder with each major change
- Keep REMAINING_TASKS.md current
- Log daily progress in logs folder
