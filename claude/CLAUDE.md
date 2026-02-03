# Code style
- Simple, readable code is preferred
- Don't be clever, be clear
- Single responsibility per method, class
- Follow existing patterns in the codebase

# Testing
- Always write tests for new features and bug fixes
- Use the existing test framework if there is one
- Prefer inline setup within each test over shared setup defined elsewhere in the file

# Workflow
- Use feature branches for new features and bug fixes
- Prefer running single tests, not the whole test suite, for performance
- Commit often with small, focused commits
- Write commit messages in the imperative mood, e.g. "Add feature" not "Added feature"

# Before taking action
- Ask before large refactors that touch many files
- Ask before deleting significant code
- Ask before adding new dependencies (gems, packages)
