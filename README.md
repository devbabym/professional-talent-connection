# Professional Talent Connection Platform

## Overview

This platform leverages blockchain technology to securely connect professionals with businesses and job opportunities. Built on the Stacks blockchain, this decentralized system allows professionals to register their profiles, companies to register and post job listings, and talent to search for new career opportunities.

### Features
- **Professional Registration**: Professionals can create profiles that include their name, skills, location, and resume.
- **Company Registration**: Companies can register on the platform with details about their name, industry, and location.
- **Job Listings**: Companies can post job opportunities, including job descriptions, locations, and required skills.
- **Secure Profile Management**: All data is stored on the blockchain, providing security and transparency for users.

---

## Contract Functions

### 1. `register-company`
Registers a new company profile.

#### Parameters:
- `company-name`: Name of the company.
- `industry`: The company's industry.
- `location`: Company location.

#### Returns:
- Success message or error if the company already exists or invalid information is provided.

---

### 2. `create-job-listing`
Creates a new job listing.

#### Parameters:
- `title`: Job title.
- `description`: Job description.
- `location`: Job location.
- `requirements`: List of required skills for the job.

#### Returns:
- Success message or error if the job listing already exists or invalid information is provided.

---

### 3. `register-professional`
Registers a new professional profile.

#### Parameters:
- `name`: Name of the professional.
- `skills`: List of professional skills.
- `location`: Professional's location.
- `resume`: A link to the professional's resume or detailed information.

#### Returns:
- Success message or error if the profile already exists or invalid information is provided.

---

## Query Functions

### 1. `get-professional-info`
Retrieves a professional's information based on their principal ID.

#### Parameters:
- `user-id`: The principal ID of the professional.

#### Returns:
- Professional's profile data or an error if not found.

---

### 2. `get-company-info`
Retrieves a company's information based on their principal ID.

#### Parameters:
- `company-id`: The principal ID of the company.

#### Returns:
- Company details or an error if not found.

---

### 3. `get-job-details`
Retrieves the details of a job listing based on the listing ID.

#### Parameters:
- `listing-id`: The principal ID of the job listing.

#### Returns:
- Job listing details or an error if not found.

---

## System Constants & Error Handling

- **Error Codes:**
  - `ERR-NOT-FOUND`: Resource not found.
  - `ERR-ALREADY-EXISTS`: Resource already exists.
  - `ERR-INVALID-SKILLS`: Invalid skill set for a professional profile.
  - `ERR-INVALID-LOCATION`: Invalid location.
  - `ERR-INVALID-RESUME`: Invalid or missing resume.
  - `ERR-INVALID-JOB-POST`: Invalid job posting.
  - `ERR-ORGANIZATION-MISSING`: Missing company details.

---

## Development

- This contract is written in **Clarity**, the smart contract language for the Stacks blockchain.
- Make sure to have the **Stacks CLI** installed to deploy and interact with the contract.

### Example Steps:
1. Register a company:
   ```javascript
   await contract.call('register-company', [companyName, industry, location]);
   ```

2. Create a job listing:
   ```javascript
   await contract.call('create-job-listing', [title, description, location, requirements]);
   ```

3. Register a professional:
   ```javascript
   await contract.call('register-professional', [name, skills, location, resume]);
   ```

---

## License

MIT License. See [LICENSE](LICENSE) for details.
