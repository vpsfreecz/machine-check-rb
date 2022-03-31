module MachineCheck
  # Provides access to usage info of the kernel keyring
  class KernelKeyring
    # @!attribute [r] uid
    #   @return [Integer] User ID
    # @!attribute [r] usage
    #   @return [Integer] Kernel-internal usage count
    # @!attribute [r] nkeys
    #   @return [Integer] The total number of keys owned by the user
    # @!attribute [r] nikeys
    #   @return [Integer] The number of `nkeys` that have been instantiated
    # @!attribute [r] qnkeys
    #   @return [Integer] The number of keys owned by the user
    # @!attribute [r] maxkeys
    #   @return [Integer] The maximum number of keys that the user may own
    # @!attribute [r] qnbytes
    #   @return [Integer] The number of bytes consumed in payloads of the keys owned by this user
    # @!attribute [r] maxbytes
    #   @return [Integer] The upper limit on the number of bytes in key payloads for the user
    KeyUser = Struct.new(
      :uid,
      :usage,
      :nkeys,
      :nikeys,
      :qnkeys,
      :maxkeys,
      :qnbytes,
      :maxbytes,
    )

    def initialize(key_users: '/proc/key-users')
      @key_users = parse_key_users(key_users)
    end

    # @yieldparam key_user [KeyUser]
    def each(&block)
      @key_users.each_value(&block)
    end

    protected
    def parse_key_users(path)
      ret = {}

      # See man keyrings(7) for the file format
      File.open(path) do |f|
        f.each_line do |line|
          uid, usage, total_keys, owned_keys, owned_bytes = line.split

          uid_int = uid[0..-2].to_i
          nkeys, nikeys = total_keys.split('/')
          qnkeys, maxkeys = owned_keys.split('/')
          qnbytes, maxbytes = owned_bytes.split('/')

          ret[uid_int] = KeyUser.new(
            uid_int,
            usage.to_i,
            nkeys.to_i,
            nikeys.to_i,
            qnkeys.to_i,
            maxkeys.to_i,
            qnbytes.to_i,
            maxbytes.to_i,
          )
        end
      end

      ret
    end
  end
end
