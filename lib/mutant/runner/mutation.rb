# encoding: utf-8

module Mutant
  class Runner
    # Mutation runner
    class Mutation < self
      include Equalizer.new(:config, :mutation)

      register Mutant::Mutation

      # Return mutation
      #
      # @return [Mutation]
      #
      # @api private
      #
      attr_reader :mutation

      # Return killer instance
      #
      # @return [Killer]
      #
      # @api private
      #
      attr_reader :killer

      # Initialize object
      #
      # @param [Config] config
      # @param [Mutation] mutation
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(config, mutation)
        @mutation = mutation
        super(config)
      end

      # Test if mutation was handeled successfully
      #
      # @return [true]
      #   if successful
      #
      # @return [false]
      #   otherwise
      #
      # @api private
      #
      def success?
        mutation.success?(killer)
      end

    private

      # Perform operation
      #
      # @return [undefined]
      #
      # @api private
      #
      def run
        @killer = config.strategy.kill(mutation)
        report(killer)
        @stop = config.fail_fast && !killer.success?
      end

    end # Mutation
  end # Runner
end # Mutant
