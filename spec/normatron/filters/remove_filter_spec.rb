# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe RemoveFilter do
      let(:word) {"ᰄ긚 ᧔瑤л꽥๏ ѨDꨥ\aՇ謬ꗀᶆᵆ쳻ῼἬ鿃ႍꥈᤫ꙲⅟౮ⅰ⅘༌_゠⟦〉⸠›⸓⌟⅂₧௹¨⣭  \u2028\u2029\u008C\u0011⁠\uA7E5" }

      it { should remove(:Graph        ).from(word) }
      it { should remove(:Punct        ).from(word) }
      it { should remove(:Upper        ).from(word) }
      it { should remove(:Word         ).from(word) }
      it { should remove(:Latin        ).from(word) }
      it { should remove(:L            ).from(word) }
      it { should remove(:M            ).from(word) }
      it { should remove(:N            ).from(word) }
      it { should remove(:P            ).from(word) }
      it { should remove(:S            ).from(word) }
      it { should remove(:Z            ).from(word) }
      it { should remove(:C            ).from(word) }
      it { should remove(:Graph, :Punct).from(word) }
      it { should remove(:Graph, :Upper).from(word) }
      it { should remove(:Graph, :Word ).from(word) }
      it { should remove(:Graph, :Latin).from(word) }
      it { should remove(:Graph, :L    ).from(word) }
      it { should remove(:Graph, :M    ).from(word) }
      it { should remove(:Graph, :N    ).from(word) }
      it { should remove(:Graph, :P    ).from(word) }
      it { should remove(:Graph, :S    ).from(word) }
      it { should remove(:Graph, :Z    ).from(word) }
      it { should remove(:Graph, :C    ).from(word) }
      it { should remove(:Punct, :Upper).from(word) }
      it { should remove(:Punct, :Word ).from(word) }
      it { should remove(:Punct, :Latin).from(word) }
      it { should remove(:Punct, :L    ).from(word) }
      it { should remove(:Punct, :M    ).from(word) }
      it { should remove(:Punct, :N    ).from(word) }
      it { should remove(:Punct, :P    ).from(word) }
      it { should remove(:Punct, :S    ).from(word) }
      it { should remove(:Punct, :Z    ).from(word) }
      it { should remove(:Punct, :C    ).from(word) }
      it { should remove(:Upper, :Word ).from(word) }
      it { should remove(:Upper, :Latin).from(word) }
      it { should remove(:Upper, :L    ).from(word) }
      it { should remove(:Upper, :M    ).from(word) }
      it { should remove(:Upper, :N    ).from(word) }
      it { should remove(:Upper, :P    ).from(word) }
      it { should remove(:Upper, :S    ).from(word) }
      it { should remove(:Upper, :Z    ).from(word) }
      it { should remove(:Upper, :C    ).from(word) }
      it { should remove(:Word, :Latin ).from(word) }
      it { should remove(:Word, :L     ).from(word) }
      it { should remove(:Word, :M     ).from(word) }
      it { should remove(:Word, :N     ).from(word) }
      it { should remove(:Word, :P     ).from(word) }
      it { should remove(:Word, :S     ).from(word) }
      it { should remove(:Word, :Z     ).from(word) }
      it { should remove(:Word, :C     ).from(word) }
      it { should remove(:Latin, :L    ).from(word) }
      it { should remove(:Latin, :M    ).from(word) }
      it { should remove(:Latin, :N    ).from(word) }
      it { should remove(:Latin, :P    ).from(word) }
      it { should remove(:Latin, :S    ).from(word) }
      it { should remove(:Latin, :Z    ).from(word) }
      it { should remove(:Latin, :C    ).from(word) }
      it { should remove(:L, :M        ).from(word) }
      it { should remove(:L, :N        ).from(word) }
      it { should remove(:L, :P        ).from(word) }
      it { should remove(:L, :S        ).from(word) }
      it { should remove(:L, :Z        ).from(word) }
      it { should remove(:L, :C        ).from(word) }
      it { should remove(:M, :N        ).from(word) }
      it { should remove(:M, :P        ).from(word) }
      it { should remove(:M, :S        ).from(word) }
      it { should remove(:M, :Z        ).from(word) }
      it { should remove(:M, :C        ).from(word) }
      it { should remove(:N, :P        ).from(word) }
      it { should remove(:N, :S        ).from(word) }
      it { should remove(:N, :Z        ).from(word) }
      it { should remove(:N, :C        ).from(word) }
      it { should remove(:P, :S        ).from(word) }
      it { should remove(:P, :Z        ).from(word) }
      it { should remove(:P, :C        ).from(word) }
      it { should remove(:S, :Z        ).from(word) }
      it { should remove(:S, :C        ).from(word) }
      it { should remove(:Z, :C        ).from(word) }
      it { should evaluate(100         ).to(100   ) }
      it { should evaluate(nil         ).to(nil   ) }
    end
  end
end    