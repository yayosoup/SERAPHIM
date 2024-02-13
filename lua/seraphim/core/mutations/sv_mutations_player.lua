local _P = FindMetaTable( "Player" )

function _P:QueueMutationSave()
    self.NextMutationSave = CurTime() + 1
end