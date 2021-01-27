module VagrantPlugins
  module CommandServe
    module Service
      class CommandService < Hashicorp::Vagrant::Sdk::CommandService::Service
        def help_spec(*args)
          Hashicorp::Vagrant::Sdk::FuncSpec.new
        end

        def help(*args)
          options = command_options_for(args.last.metadata["plugin_name"])
          Hashicorp::Vagrant::Sdk::Command::HelpResp.new(
            help: options.help
          )
        end

        def synopsis_spec(*args)
          return Hashicorp::Vagrant::Sdk::FuncSpec.new
        end

        def synopsis(*args)
          plugin_name = args.last.metadata["plugin_name"]
          plugin = Vagrant::Plugin::V2::Plugin.manager.commands[plugin_name.to_sym].to_a.first
          if !plugin
            raise "Failed to locate command plugin for: #{plugin_name}"
          end
          klass = plugin.call
          Hashicorp::Vagrant::Sdk::Command::SynopsisResp.new(
            synopsis: klass.synopsis
          )
        end

        def flags_spec(*args)
          Hashicorp::Vagrant::Sdk::FuncSpec.new
        end

        def flags(*args)
          options = command_options_for(args.last.metadata["plugin_name"])

          # Now we can build our list of flags
          flags = options.top.list.find_all { |o|
            o.is_a?(OptionParser::Switch)
          }.map { |o|
            Hashicorp::Vagrant::Sdk::Command::Flag.new(
              description: o.desc.join(" "),
              long_name: o.long.first,
              short_name: o.short.first,
              type: o.is_a?(OptionParser::Switch::NoArgument) ?
                Hashicorp::Vagrant::Sdk::Command::Flag::Type::BOOL :
                Hashicorp::Vagrant::Sdk::Command::Flag::Type::STRING
            )
          }

          # Clean our option data out of the thread
          Thread.current.thread_variable_set(:command_options, nil)

          Hashicorp::Vagrant::Sdk::Command::FlagsResp.new(
            flags: flags
          )
        end

        def command_options_for(name)
          plugin = Vagrant::Plugin::V2::Plugin.manager.commands[name.to_sym].to_a.first
          if !plugin
            raise "Failed to locate command plugin for: #{name}"
          end

          # Create a new anonymous class based on the command class
          # so we can modify the setup behavior
          klass = Class.new(plugin.call)

          # Update the option parsing to store the provided options, and then return
          # a nil value. The nil return will force the command to call help and not
          # actually execute anything.
          klass.class_eval do
            def parse_options(opts)
              Thread.current.thread_variable_set(:command_options, opts)
              nil
            end
          end

          # Execute the command to populate our options
          klass.new([], {}).execute

          options = Thread.current.thread_variable_get(:command_options)

          # Clean our option data out of the thread
          Thread.current.thread_variable_set(:command_options, nil)

          # Send the options back
          options
        end
      end
    end
  end
end
