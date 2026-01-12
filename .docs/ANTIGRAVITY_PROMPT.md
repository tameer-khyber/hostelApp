# Antigravity AI Prompt for HostelApp

> **Both Moazzam and Tammer use this same prompt**  
> Last Updated: 2026-01-12

---

## 🚀 UNIVERSAL PROMPT (Copy and paste when starting)

```
I'm working on the HostelApp Flutter project.

## MY IDENTITY
**My name is:** [WRITE YOUR NAME: Moazzam or Tammer]

## FIRST, READ THE TRACKING FOLDER:
1. Read `.docs/TEAM_OVERVIEW.md` - Quick project status
2. Read `.docs/PROJECT_STATUS.md` - Branch info, all completed work
3. Read `.docs/REMAINING_TASKS.md` - What needs to be done
4. Read `.docs/SUGGESTIONS.md` - Architecture ideas

## PROJECT CONTEXT:
- Flutter app for hostel/property management
- State management: GetX
- Global widgets: `lib/app/global_widgets/`
- Constants: `lib/app/config/constants/`
- Utilities: `lib/app/core/`

## RULES TO FOLLOW:
1. Use global widgets (PrimaryButton, AppTextField, etc.) - don't recreate them
2. Use AppStrings for all text
3. Use AppConstants for spacing/sizing
4. Use Validators for form validation
5. Check git branch before making changes
6. Test build before committing

## WHEN I SAY "done working for today":
Create/update my daily log file at `.docs/logs/[myname]/YYYY-MM-DD.md` with:
- All work I completed this session
- All commits I made
- Any issues encountered
- Notes for next session
Then update `.docs/PROJECT_STATUS.md` with my contributions.

Please analyze the project, read the tracking files, and tell me:
1. Current project status
2. What work is remaining
3. What you suggest I work on today
```

---

## 📝 How It Works

### Starting a Session

1. Copy the prompt above
2. **Replace `[WRITE YOUR NAME: Moazzam or Tammer]` with your actual name**
3. Paste into Antigravity
4. AI reads tracking files and gives you status

### During Work

- AI follows established patterns
- Uses global widgets, constants, validators
- Commits with descriptive messages

### Ending a Session

Just say: **"done working for today"**

AI will automatically:

- Create your daily log file (`.docs/logs/[yourname]/YYYY-MM-DD.md`)
- Update PROJECT_STATUS.md with your work
- List all commits and changes made

---

## 🔑 Key Points

| Question | Answer |
|----------|--------|
| Does AI know who I am? | **NO** - You must specify your name |
| Where do I write my name? | In the prompt: `My name is: [YOUR NAME]` |
| How to save my work log? | Say "done working for today" |
| Where are logs saved? | `.docs/logs/[yourname]/YYYY-MM-DD.md` |

---

## 📋 Quick Reference

### Moazzam's log folder

`.docs/logs/moazzam/`

### Tammer's log folder

`.docs/logs/tammer/`

### Check branch before starting

```bash
git branch
git status
```

### Test before committing

```bash
flutter build apk --debug
```
