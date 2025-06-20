## Deal Finder

### Background
You are building a “Deal Finder” feature for a Groupon-style application that helps users discover the best deals based on their preferences. We have a dataset of deals and need backend filtering/ranking service.

---
### Instructions
- **Deadline:** 1 week from assignment.
- **Effort Estimate:** Plan to spend around 4 hours; do not exceed 8 hours.
- **Submission:** Share your source code via GitHub (or a similar service).

---
### Backend

#### Objectives
- Expose an API endpoint that accepts search criteria and returns matching deals.
- Implement a custom search & ranking algorithm to score deal relevance.
- Handle errors and edge cases gracefully.
- Provide at least one unit test for the core filtering/ranking logic.

#### Functional Requirements
- **Data Storage**
  - Use any data storage method you like.
- **Filtering**
  - Filter deals by multiple criteria: price range, category, location, etc.
- **Ranking**
  - Design and apply a scoring algorithm (e.g., weight by discount%, distance, popularity).
- **Edge Cases**
  - Return reasonable messages to the user.
  - Validate and sanitize user input.
- **Performance**
  - Ensure acceptable response times on large datasets (consider sorting/filtering complexity).
- **Testing**
  - Write at least one unit test.
---

### Evaluation Criteria

1. **Code Quality**
   - Clean, modular, and well-documented code
   - Consistent naming conventions
3. **Functionality**
   - Accurate filtering and ranking
   - Robust error and edge-case handling
4. **Performance**
   - Efficient algorithms (sorting/filtering)
5. **Testing**
   - At least one meaningful unit test
   - Clear test cases and rationale

---

### Optional Stretch Goals
- **CRUD**
  - Implement CRUD API endpoints and logic

---

Good luck!
Feel free to add any additional documentation or scripts you think would showcase your solution.
