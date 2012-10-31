# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe KeepFilter do
      let(:word) {"ᰄ긚 ᧔瑤л꽥๏ ѨDꨥ\aՇ謬ꗀᶆᵆ쳻ῼἬ鿃ႍꥈᤫ꙲⅟౮ⅰ⅘༌_゠⟦〉⸠›⸓⌟⅂₧௹¨⣭  \u2028\u2029\u008C\u0011⁠\uA7E5" }

      it { should keep(:Graph        ).from(word) }
      it { should keep(:Punct        ).from(word) }
      it { should keep(:Upper        ).from(word) }
      it { should keep(:Word         ).from(word) }
      it { should keep(:Latin        ).from(word) }
      it { should keep(:L            ).from(word) }
      it { should keep(:M            ).from(word) }
      it { should keep(:N            ).from(word) }
      it { should keep(:P            ).from(word) }
      it { should keep(:S            ).from(word) }
      it { should keep(:Z            ).from(word) }
      it { should keep(:C            ).from(word) }
      it { should keep(:Graph, :Punct).from(word) }
      it { should keep(:Graph, :Upper).from(word) }
      it { should keep(:Graph, :Word ).from(word) }
      it { should keep(:Graph, :Latin).from(word) }
      it { should keep(:Graph, :L    ).from(word) }
      it { should keep(:Graph, :M    ).from(word) }
      it { should keep(:Graph, :N    ).from(word) }
      it { should keep(:Graph, :P    ).from(word) }
      it { should keep(:Graph, :S    ).from(word) }
      it { should keep(:Graph, :Z    ).from(word) }
      it { should keep(:Graph, :C    ).from(word) }
      it { should keep(:Punct, :Upper).from(word) }
      it { should keep(:Punct, :Word ).from(word) }
      it { should keep(:Punct, :Latin).from(word) }
      it { should keep(:Punct, :L    ).from(word) }
      it { should keep(:Punct, :M    ).from(word) }
      it { should keep(:Punct, :N    ).from(word) }
      it { should keep(:Punct, :P    ).from(word) }
      it { should keep(:Punct, :S    ).from(word) }
      it { should keep(:Punct, :Z    ).from(word) }
      it { should keep(:Punct, :C    ).from(word) }
      it { should keep(:Upper, :Word ).from(word) }
      it { should keep(:Upper, :Latin).from(word) }
      it { should keep(:Upper, :L    ).from(word) }
      it { should keep(:Upper, :M    ).from(word) }
      it { should keep(:Upper, :N    ).from(word) }
      it { should keep(:Upper, :P    ).from(word) }
      it { should keep(:Upper, :S    ).from(word) }
      it { should keep(:Upper, :Z    ).from(word) }
      it { should keep(:Upper, :C    ).from(word) }
      it { should keep(:Word, :Latin ).from(word) }
      it { should keep(:Word, :L     ).from(word) }
      it { should keep(:Word, :M     ).from(word) }
      it { should keep(:Word, :N     ).from(word) }
      it { should keep(:Word, :P     ).from(word) }
      it { should keep(:Word, :S     ).from(word) }
      it { should keep(:Word, :Z     ).from(word) }
      it { should keep(:Word, :C     ).from(word) }
      it { should keep(:Latin, :L    ).from(word) }
      it { should keep(:Latin, :M    ).from(word) }
      it { should keep(:Latin, :N    ).from(word) }
      it { should keep(:Latin, :P    ).from(word) }
      it { should keep(:Latin, :S    ).from(word) }
      it { should keep(:Latin, :Z    ).from(word) }
      it { should keep(:Latin, :C    ).from(word) }
      it { should keep(:L, :M        ).from(word) }
      it { should keep(:L, :N        ).from(word) }
      it { should keep(:L, :P        ).from(word) }
      it { should keep(:L, :S        ).from(word) }
      it { should keep(:L, :Z        ).from(word) }
      it { should keep(:L, :C        ).from(word) }
      it { should keep(:M, :N        ).from(word) }
      it { should keep(:M, :P        ).from(word) }
      it { should keep(:M, :S        ).from(word) }
      it { should keep(:M, :Z        ).from(word) }
      it { should keep(:M, :C        ).from(word) }
      it { should keep(:N, :P        ).from(word) }
      it { should keep(:N, :S        ).from(word) }
      it { should keep(:N, :Z        ).from(word) }
      it { should keep(:N, :C        ).from(word) }
      it { should keep(:P, :S        ).from(word) }
      it { should keep(:P, :Z        ).from(word) }
      it { should keep(:P, :C        ).from(word) }
      it { should keep(:S, :Z        ).from(word) }
      it { should keep(:S, :C        ).from(word) }
      it { should keep(:Z, :C        ).from(word) }
      it { should evaluate(100       ).to(100   ) }
      it { should evaluate(nil       ).to(nil   ) }
    end
  end
end    