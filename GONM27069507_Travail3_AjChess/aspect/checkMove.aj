package ca.uqac.inf957.chess.aspect;

import ca.uqac.inf957.chess.piece.Bishop;
import ca.uqac.inf957.chess.piece.King;
import ca.uqac.inf957.chess.piece.Knight;
import ca.uqac.inf957.chess.piece.Pawn;
import ca.uqac.inf957.chess.piece.Piece;
import ca.uqac.inf957.chess.piece.Queen;
import ca.uqac.inf957.chess.piece.Rook;
import ca.uqac.inf957.chess.agent.*;
import ca.uqac.inf957.chess.Board;

public aspect checkMove {
	
	/*
	 * 
	 * 
	 * Déclaration des pointcuts
	 * 
	 * 
	 */
	
	
	pointcut PlayerMakeMove(Player p, Move mv) : 
		target(p)
		&& execution(boolean Player.move(Move))
		&& args(mv);
	
	
	
	pointcut KingMove(King p, Move mv) : 
		target(p) 
		&& execution( boolean King.isMoveLegal(Move))
		&& args(mv); 
	
	
	pointcut QueenMove(Queen q, Move mv) : 
		target(q) 
		&& execution( boolean Queen.isMoveLegal(Move))
		&& args(mv); 
	
	pointcut KnightMove(Knight k, Move mv) : 
		target(k) 
		&& execution( boolean Knight.isMoveLegal(Move))
		&& args(mv); 
	
	pointcut PawnMove(Pawn p, Move mv) : 
		target(p) 
		&& execution( boolean Pawn.isMoveLegal(Move))
		&& args(mv); 
	
	pointcut BishopMove(Bishop b, Move mv) : 
		target(b) 
		&& execution( boolean Bishop.isMoveLegal(Move))
		&& args(mv); 
	
	pointcut RookMove(Rook r, Move mv) : 
		target(r) 
		&& execution( boolean Rook.isMoveLegal(Move))
		&& args(mv); 
	
	
	
	/*
	 * 
	 * 
	 * Déclaration des advices
	 * 
	 * 
	 */
	
	
	boolean around(Player p, Move mv) : PlayerMakeMove(p,mv){
		//Réécriture de la méthode boolean Player.move(Move)
		
		
		if((mv.xI >= Board.SIZE || mv.xI < 0) || (mv.yI >= Board.SIZE || mv.yI < 0))
		{
			System.out.println("Illegal Move");
			return false;
		}
		
		if(p.getPlayGround().getGrid()[mv.xI][mv.yI].isOccupied())
		{
			if(p.getPlayGround().getGrid()[mv.xI][mv.yI].getPiece().getPlayer()==p.getColor())
			{
			
				
	
						if(p.getPlayGround().getGrid()[mv.xI][mv.yI].getPiece().isMoveLegal(mv))
						{
							
							
							if(p.getPlayGround().getGrid()[mv.xI][mv.yI].getPiece().isPathFree(p, mv))
							{
								p.getPlayGround().movePiece(mv);
								
								return true;
							}
						}
					
						
			}
			
		}
		
		System.out.println("Illegal Move");
		return false;
		
		
	}
	
	
	boolean around(King k, Move mv)	: KingMove(k,mv){
		//Réécriture de la méthode boolean King.isMoveLegal(Move)
		
		/*
		 * 
		 * Renvoie "true" si le mouvement correspond au mouvement d'un Roi, false sinon
		 * 
		 */
		System.out.println("Checking King Move : " + mv.toString());
		
		if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0))
			return false;
		
		int movX=Math.abs(mv.xF-mv.xI);
		int movY=Math.abs(mv.yF-mv.yI);


		if((movX==1 && movY==1) || (movX==1 && movY==0) || (movX==0 && movY==1))
		{
			return true;
		}
		
		return false;
		
	}
	
	
	boolean around(Queen q, Move mv)	: QueenMove(q,mv)
	//Réécriture de la méthode boolean Queen.isMoveLegal(Move)
	
	
	/*
	 * 
	 * Renvoie "true" si le mouvement correspond au mouvement d'une Reine, false sinon
	 * 
	 */
	{
		System.out.println("Checking Queen Move : " + mv.toString());
		
		
		if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0))
			return false;
		
		int movX=Math.abs(mv.xF-mv.xI);
		int movY=Math.abs(mv.yF-mv.yI);		
		
		if ((movX!=0 && movY==0) || (movX==0 && movY!=0))
		{
		return true;
		}
		
		if(movY!=0)
		{
			return (movX/movY)==1; 
			
		}
			
		return false;
		
	}
	
	
	
	boolean around(Knight k, Move mv)	: KnightMove(k,mv){
		//Réécriture de la méthode boolean Knight.isMoveLegal(Move)
		
		/*
		 * 
		 * Renvoie "true" si le mouvement correspond au mouvement d'un Cavalier, false sinon
		 * 
		 */
		System.out.println("Checking Knight Move : " + mv.toString());
		
		if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0))
			return false;
		
		int movX=Math.abs(mv.xF-mv.xI);
		int movY=Math.abs(mv.yF-mv.yI);	
		
		
		if((movX == 2 && movY == 1) || (movX == 1 && movY == 2))
		{
		return true;
		}
		
		return false;
		
	}
	
	
	boolean around(Pawn p, Move mv)	: PawnMove(p, mv){
		//Réécriture de la méthode boolean Pawn.isMoveLegal(Move)
		
		/*
		 * 
		 * Renvoie "true" si le mouvement correspond au mouvement d'un Pion, false sinon
		 * 
		 */
		System.out.println("Checking Pawn Move : " + mv.toString());
		
		System.out.println(mv.xF);
		if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0))
			return false;
		
		
		int movX=mv.xF-mv.xI;
		int movY=mv.yF-mv.yI;
		
		if((movX==0) || (movX==1) || (movX==-1)) {	
			if(p.getPlayer()==Player.BLACK) 
			{
			
				if(movY == -1)
				{
					
	
					return true;
				}
			
			}else if (p.getPlayer()==Player.WHITE)
				
			{
				if(movY == 1)
				{
					return true;
				}
				
			}
		}
		return false;
		
	}
	
	boolean around(Bishop b, Move mv)	: BishopMove(b, mv){
		//Réécriture de la méthode boolean Bishop.isMoveLegal(Move)
		
		/*
		 * 
		 * Renvoie "true" si le mouvement correspond au mouvement d'un Fou, false sinon
		 * 
		 */
		System.out.println("Checking Bishop Move : " + mv.toString());
		
		if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0))
			return false;
		
		
		
		int movX=Math.abs(mv.xF-mv.xI);
		int movY=Math.abs(mv.yF-mv.yI);		
		
		if ((movX!=0 && movY!=0))
		{
			return (movX/movY)==1;
		}
			
		return false;
		
		
	}	
	
	boolean around(Rook r, Move mv)	: RookMove(r, mv){
		//Réécriture de la méthode boolean Rook.isMoveLegal(Move)
		
		/*
		 * 
		 * Renvoie "true" si le mouvement correspond au mouvement d'une Tour, false sinon
		 * 
		 */
		System.out.println("Checking Rook Move : " + mv.toString());
		
		
		if((mv.xF >= Board.SIZE || mv.xF < 0) || (mv.yF >= Board.SIZE || mv.yF < 0))
			return false;
		
		
		int movX=Math.abs(mv.xF-mv.xI);
		int movY=Math.abs(mv.yF-mv.yI);		
		
		if ((movX!=0 && movY==0) || (movX==0 && movY!=0))
		{
			return true;
		}
			
		return false;
		
	}	
	
	
	
	
	
	
	/*
	 * 
	 * Ajout de la méthode  Piece.isPathFree(Player p, Move mv) et définition de celle-ci pour toutes les pièces
	 * Cette méthode vérifie que la configuration du plateau permet le mouvement, doit être appelée après
	 * la méthode Piece.isMoveLegal().
	 * 
	 * 
	 */
	
	
	public abstract boolean Piece.isPathFree(Player p, Move mv);
	
	
	public boolean Queen.isPathFree(Player p,Move mv){
		if(p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied())
		{
			if(p.getPlayGround().getGrid()[mv.xF][mv.yF].getPiece().getPlayer() == this.getPlayer())
			{
				return false;
				
			}
			
			
		}
		
	
		if((mv.xF-mv.xI)==0 || (mv.yF-mv.yI)==0)
		{
			if(mv.xF > mv.xI) {
				
				
				for(int i = mv.xI+1;i<mv.xF;i++) {
					
					if(p.getPlayGround().getGrid()[i][mv.yF].isOccupied()) {
						
						return false;
						
					}
					
				}

			}
			
			if(mv.xF < mv.xI) {
				
				
				for(int i = mv.xI-1;i>mv.xF;i--) {
					
					if(p.getPlayGround().getGrid()[i][mv.yF].isOccupied()) {
						
						return false;
						
					}
					
				}

			}
			
			if(mv.yF > mv.yI) {
				
				
				for(int i = mv.yI+1;i<mv.yF;i++) {
					
					if(p.getPlayGround().getGrid()[mv.xF][i].isOccupied()) {
						
						return false;
						
					}
					
				}

			}
			
			if(mv.yF < mv.yI) {
				
				
				for(int i = mv.yI-1;i>mv.yF;i--) {
					
					if(p.getPlayGround().getGrid()[mv.xF][i].isOccupied()) {
						
						return false;
						
					}
					
				}

			}
			return true;
			
		}else
		{
			if(mv.xF > mv.xI && mv.yF > mv.yI) {
				
				
				for(int i = mv.xI+1,j = mv.yI+1;i<mv.xF;i++, j++) {
					
					if(p.getPlayGround().getGrid()[i][j].isOccupied()) {
						
						return false;
						
					}
					
				}

			}
			
			if(mv.xF < mv.xI && mv.yF > mv.yI) {
				
				
				for(int i = mv.xI-1,j=mv.yF+1;i>mv.xF;i--,j++) {
					
					if(p.getPlayGround().getGrid()[i][j].isOccupied()) {
						
						return false;
						
					}
					
				}

			}
			
			if(mv.xF > mv.xI && mv.yF < mv.yI) {
				
				
				for(int i = mv.yI+1,j=mv.yI-1;i<mv.xF;i++,j--) {
					
					if(p.getPlayGround().getGrid()[i][j].isOccupied()) {
						
						return false;
						
					}
					
				}

			}
			
			if(mv.xF < mv.xI && mv.yF < mv.yI) {
				
				
				for(int i = mv.xI-1,j=mv.yI-1;i>mv.xF;i--,j--) {
					
					if(p.getPlayGround().getGrid()[i][j].isOccupied()) {
						
						return false;
						
					}
					
				}

			}
			return true;
			
			
		}
	
	
	
	
	
	}
	
	
	
	
	public boolean Bishop.isPathFree(Player p,Move mv){
		if(p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied())
		{
			if(p.getPlayGround().getGrid()[mv.xF][mv.yF].getPiece().getPlayer() == this.getPlayer())
			{
				return false;
				
			}
			
			
		}
			
			
			
			
		if(mv.xF > mv.xI && mv.yF > mv.yI) {
			
			
			for(int i = mv.xI+1,j = mv.yI+1;i<mv.xF;i++, j++) {
				
				if(p.getPlayGround().getGrid()[i][j].isOccupied()) {
					
					return false;
					
				}
				
			}

		}
		
		if(mv.xF < mv.xI && mv.yF > mv.yI) {
			
			
			for(int i = mv.xI-1,j=mv.yF+1;i>mv.xF;i--,j++) {
				
				if(p.getPlayGround().getGrid()[i][j].isOccupied()) {
					
					return false;
					
				}
				
			}

		}
		
		if(mv.xF > mv.xI && mv.yF < mv.yI) {
			
			
			for(int i = mv.yI+1,j=mv.yI-1;i<mv.xF;i++,j--) {
				
				if(p.getPlayGround().getGrid()[i][j].isOccupied()) {
					
					return false;
					
				}
				
			}

		}
		
		if(mv.xF < mv.xI && mv.yF < mv.yI) {
			
			
			for(int i = mv.xI-1,j=mv.yI-1;i>mv.xF;i--,j--) {
				
				if(p.getPlayGround().getGrid()[i][j].isOccupied()) {
					
					return false;
					
				}
				
			}

		}
		return true;
		
	
		
	
	
	
	}
	
	
	
	
	
	
	
	public boolean Rook.isPathFree(Player p,Move mv)
	{
		
		
		
		if(p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied())
		{
			if(p.getPlayGround().getGrid()[mv.xF][mv.yF].getPiece().getPlayer() == this.getPlayer())
			{
	
				return false;
				
			}
			
			
		}
			
			
			
			
		if(mv.xF > mv.xI) {
			
			
			for(int i = mv.xI+1;i<mv.xF;i++) {
				
				if(p.getPlayGround().getGrid()[i][mv.yF].isOccupied()) {
		
					return false;
					
				}
				
			}

		}
		
		if(mv.xF < mv.xI) {
			
			
			for(int i = mv.xI-1;i>mv.xF;i--) {
				
				if(p.getPlayGround().getGrid()[i][mv.yF].isOccupied()) {
			
					return false;
					
				}
				
			}

		}
		
		if(mv.yF > mv.yI) {
			
			
			for(int i = mv.yI+1;i<mv.yF;i++) {
				
				if(p.getPlayGround().getGrid()[mv.xF][i].isOccupied()) {
	
					return false;
					
				}
				
			}

		}
		
		if(mv.yF < mv.yI) {
			
			
			for(int i = mv.yI-1;i>mv.yF;i--) {
				
				if(p.getPlayGround().getGrid()[mv.xF][i].isOccupied()) {
		
					return false;
					
				}
				
			}

		}
		return true;
		
	
	
	}
	
	
	
	
	public boolean Pawn.isPathFree(Player p,Move mv){
		
		int movX=mv.xF-mv.xI;
		
		if(movX==0 && !p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied()) {
			return true;
		}else if(movX!=0 && p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied()) { 
			if(p.getPlayGround().getGrid()[mv.xF][mv.yF].getPiece().getPlayer() != this.getPlayer())
			{	System.out.println("I'm in");
				return true;
			}else
			{
				return false;
			}
		}else {
			return false;
		}
		
	
	}
	
	
	
	
	public boolean King.isPathFree(Player p,Move mv)
	{
		if(!p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied())
		{
			return true;
		}else if(p.getPlayGround().getGrid()[mv.xF][mv.yF].getPiece().getPlayer() != this.getPlayer()){
			return true;
		}else {
			return false;
		}
		
		
	}
	public boolean Knight.isPathFree(Player p,Move mv)
	{
		if(!p.getPlayGround().getGrid()[mv.xF][mv.yF].isOccupied())
		{
			return true;
		}else if(p.getPlayGround().getGrid()[mv.xF][mv.yF].getPiece().getPlayer() != this.getPlayer()){
			return true;
		}else {
			return false;
		}
		
		
	
	}
	
}
