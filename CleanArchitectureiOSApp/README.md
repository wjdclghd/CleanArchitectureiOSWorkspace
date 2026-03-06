## iOSCleanArchitecture
- iOS Project – CI/CD Setup with Xcode + CocoaPods + Fastlane + GitHub Actions + Submodule
---


## Project Overview
- This project was initiated as a solo development effort and is structured to scale for team collaboration and automated deployment (CI/CD). The goal is to establish a stable and maintainable development and release environment for iOS applications with minimal configuration.
---


## Tech Stack
- Xcode (Swift): Native iOS development
- CocoaPods: Dependency management
- SwiftPackage  
- Fastlane: Automated testing and deployment 
- GitHub Actions: CI/CD pipeline integration 
- GitHub: Source control with conflict minimization setup
---


## Tools & Setup
- macOS 15 (Xcode 16.3)
- Ruby 3.2 + Bundler
- CocoaPods for dependency resolution
- Fastlane for automated build and test processes


## Project Structure (Summary)
- `.gitignore` Ignores caches, logs, sensitive files, and integrates with CI/CD, Fastlane, and Pods
- `.gitattributes` Prevents Git merge conflicts and enforces consistent line endings
- `Fastlane/` Contains Fastlane automation scripts
- `Pods/` CocoaPods dependencies (excluded from Git)
- `iOSCleanArchitecture.xcodeproj` Xcode project file
- `iOSCleanArchitecture.xcworkspace` Xcode workspace with CocoaPods integration
- `Podfile` CocoaPods configuration
- `Gemfile` – Ruby gem dependencies (e.g., Fastlane, Bundler)
- `README.md` Project documentation
---


## Getting Started
1. Install Ruby Dependencies (Fastlane, etc.)
 - $ bundle install
1. Install Dependencies: 
 - $ bundle exec pod install
2. Open the Project:
 - open iOSCleanArchitecture.xcworkspace
---


## Running Tests
1. Run unit tests via Fastlane:
 - $ bundle exec fastlane test
 - Tests are also triggered automatically via GitHub Actions upon push or pull request.
2. Key Fastlane Commands
 - `bundle exec fastlane unit_test` — Run unit tests
 - `bundle exec fastlane develop_build` — Build without code signing (for development)
 - (예정) `bundle exec fastlane release_build` — Build and deploy with code signing
---


## CI/CD Pipeline
- Triggers on push or pull request to main, develop, release, hotfix, and feature branches
- Executes Fastlane lanes (unit_test, develop_build, etc.)
- Future plans include release automation with code signing and provisioning profiles
- Workflow configuration is located in : .github/workflows/ios-ci.yml 
---


## Secrets & Environment Variables
- Sensitive information is managed via .env and .env.* files
API_KEY=your_key_here, 
APPLE_ID=your_email@apple.com 
- These files are excluded from Git via .gitignore.
---


## Notes for Collaborators
- .gitattributes is used to minimize merge conflicts  
- Pods/ is excluded from the repo, so run pod install after cloning
- Personal build settings and caches are ignored
---


## License

---


> Created by: JEONG, Chi-hong
> Initial version: June 2025
