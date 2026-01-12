# Antigravity AI Prompt for HostelApp

> **Copy and paste this entire prompt when starting a new Antigravity session**

---

## 🚀 PROMPT FOR TAMMER (or any team member)

```
I'm working on the HostelApp Flutter project. Before we start:

1. **READ THE TRACKING FOLDER FIRST:**
   - Read `.docs/TEAM_OVERVIEW.md` for quick project status
   - Read `.docs/PROJECT_STATUS.md` for detailed branch info and completed work
   - Read `.docs/REMAINING_TASKS.md` for what needs to be done
   - Read `.docs/SUGGESTIONS.md` for architecture and improvement ideas

2. **UNDERSTAND THE CONTEXT:**
   - This is a hostel/property management Flutter app
   - We're using GetX for state management
   - We have a professional component library in `lib/app/global_widgets/`
   - We have constants in `lib/app/config/constants/`
   - We have utilities in `lib/app/core/`

3. **MY NAME IS:** [Moazzam/Tammer] (replace with your name)

4. **BRANCH STATUS:**
   - Check which branch I'm on with `git branch`
   - The refactoring work is on `feature/code-refactoring`
   - Main branch should be stable

5. **FOLLOW THESE PATTERNS:**
   - Use global widgets (PrimaryButton, AppTextField, etc.) instead of custom ones
   - Use AppStrings for all text
   - Use AppConstants for spacing/sizing
   - Use Validators for form validation
   - Use Helpers for snackbars and formatting

6. **AFTER COMPLETING WORK:**
   - Update `.docs/PROJECT_STATUS.md` with what you did
   - Create/update your log file in `.docs/logs/[yourname]/YYYY-MM-DD.md`
   - Mark completed tasks in `.docs/REMAINING_TASKS.md`
   - Commit with descriptive messages

Please analyze the project structure, read the tracking files, and let me know what you understand and what tasks I should work on today.
```

---

## 📋 Quick Commands Reference

### Check Project Status

```
Read .docs/PROJECT_STATUS.md and .docs/REMAINING_TASKS.md
```

### Start Working on a Task

```
I want to work on [TASK_NAME]. First read the tracking folder, then proceed.
```

### After Completing Work

```
Update the tracking files in .docs/ with today's work and commit.
```

---

## ⚠️ Important Notes

1. **Always read `.docs/` folder first** in a new session
2. **Check git branch** before making changes
3. **Test build** before committing: `flutter build apk --debug`
4. **Update logs** at end of each session
5. **Use existing widgets** - don't recreate what exists
