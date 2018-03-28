module CIHelper
    GITHUB_TOKEN = ENV['GITHUB_TOKEN']
    PULL_REQUEST = ENV['CI_PULL_REQUEST'] ? URI(ENV['CI_PULL_REQUEST']).path.split('/').last : "false"
    BUILD_DIR = ENV['CIRCLE_WORKING_DIRECTORY'] ? ENV['CIRCLE_WORKING_DIRECTORY'].gsub(/\~/, "#{ENV['HOME']}") : "#{ENV['HOME']}/#{ENV['CIRCLE_PROJECT_REPONAME']}"

    # Run a given command from the ci build directory
    def self.cd_run(command)
        `cd #{CIHelper::BUILD_DIR} && #{command}`
    end

    # Checks if commit has a deploy message in it
    def self.has_deploy_message?
        CIHelper::cd_run('git log -n1 --oneline --no-merges | grep -e \'\\[ci deploy\\]\' -e \'\\[deploy ci\\]\'| wc -l').to_s().strip! != "0"
    end

    def self.spec_version
        require 'cocoapods'

        podspec_path = "#{CIHelper::BUILD_DIR}/MLUI.podspec"
        spec = Pod::Specification.from_file(podspec_path)
        spec.version.to_s()
    end

    # Gets the notes of the last version (lines between tags #) in CHANGELOG.md file
    def self.get_release_notes
        changelog_path = "#{CIHelper::BUILD_DIR}/CHANGELOG.md"
        unless File.exist?(changelog_path)
            puts "Changelog was not found in expected path: '#{changelog_path}'"
            return ""
        end

        changelog = File.open(changelog_path).read
        release_notes = ""
        changelog.each_line do |line|
            if line.strip.empty?
                next
            end

            if /^#[[:blank:]]+v([[:digit:]]+\.){2}[[:digit:]]+/ =~ line
                if release_notes.empty?
                    next # Current version title
                else
                    break # Next version title
                end
            end
            release_notes += line
        end

        return release_notes
    end

    def self.get_base_branch
        if !PULL_REQUEST.to_s.empty? && PULL_REQUEST != "false"
            begin
                return get_pr_info.base.ref
            rescue Exception => e
                $stderr.puts "[!] Cannot obtain base branch name from GitHub. Error: #{e.message}"
                return nil
            end
        end
        return ENV['CIRCLE_BRANCH']
    end
end
